//
//  NewsfeedModelView.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol NewsfeedModelViewProtocol {
    
    func viewIsReady()
    
    func getNewsfeed()
    
    func searchDidChange(text: String)
    
}

class NewsfeedModelView: NSObject, NewsfeedModelViewProtocol {
    
    public weak var view: (UIViewController & NewsfeedViewControllerProtocol)!
    
    public var newsfeedService: NewsfeedServiceProtocol!
    public var userService: UserServiceProtocol!
    
    private var isExpandedItems: [Bool] = []
    private var isFetchInProgress = false
    
    func viewIsReady() {
        self.view.setupInitialState()
        self.getNewsfeed()
        self.getUser()
    }
    
    func searchDidChange(text: String) {
//        guard !isFetchInProgress else {
//            return
//        }
//        
//        isFetchInProgress = true
//        
//        newsfeedService.searchNewsfeed(query: text, count: 5, startFrom: nil) { [weak self] result in
//            guard let response = result?.response else {
//                self?.view.stopRefreshing()
//                return
//            }
//            
//            let posts = response.compactMap { item -> Post? in
//
//                var owner: Owner? = nil
//
//                switch item {
//                case .integer:
//                    return nil
//                case .searchResultResponseClass(let item):
//                    if let group = item .group {
//                        owner = Owner(group: group)
//                    } else if let profile = item.user {
//                        owner = Owner(profile: profile)
//                    }
//
//                    return Post(owner: owner, searchResult: item)
//                }
//            }
//
//            self?.isExpandedItems = Array<Bool>(repeating: false, count: posts.count)
//
//            self?.view.configureWithItem(posts, isExpanded: self?.isExpandedItems ?? [])
//            self?.view.stopRefreshing()
//        }
    }
    
    func getNewsfeed() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        newsfeedService.getNewsfeed(count: 50, startFrom: nil) { [weak self] result in
            guard let response = result?.response else {
                self?.view.stopRefreshing()
                self?.isFetchInProgress = false
                return
            }
            
            let items = response.items?.filter{ $0.type == .post }
            
            let posts = items?.compactMap { item -> Post in
                var owner: Owner? = nil
                
                if let sourceID = item.sourceID {
                    if let profile = response.profiles?.first(where: { $0.uid == -sourceID || $0.uid == sourceID  }) {
                        owner = Owner(profile: profile)
                    } else if let group = response.groups?.first(where: { $0.gid == -sourceID || $0.gid == sourceID }) {
                        owner = Owner(group: group)
                    }
                }
                
                return Post(owner: owner, newsfeed: item)
            }
            
            self?.isExpandedItems = Array<Bool>(repeating: false, count: posts?.count ?? 0)
            
            self?.view.configureWithItem(posts ?? [], isExpanded: self?.isExpandedItems ?? [])
            self?.view.stopRefreshing()
            self?.isFetchInProgress = false
        }
    }
    
    func getUser() {
        userService.getUser { [weak self] result in
            guard let response = result?.response, let user = response.first else {
                return
            }
            
            self?.view.configureSearch(user)
        }
    }
    

    
}
