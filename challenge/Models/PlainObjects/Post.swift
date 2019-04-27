//
//  Post.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

struct Owner {
    let name: String
    let photo: String?
    
    init(profile: NewsfeedProfile) {
        let firstName = profile.firstName ?? ""
        let lastName = " \(profile.lastName ?? "")"
        self.name = "\(firstName)\(lastName)"
        self.photo = profile.photo
    }
    
    init(group: NewsfeedGroup) {
        self.name = group.name ?? ""
        self.photo = group.photo
    }
}

struct Post {
    let owner: Owner?
    
    let date: Int
    let text: String?
    
    let likes: NewsfeedItemLikes?
    let comments: NewsfeedItemComments?
    let reposts: NewsfeedReposts?
    //let views: NewsfeedViews?
    
    let attachments: [NewsfeedAttachment]
    
    init(owner: Owner?, newsfeed: NewsfeedItem) {
        self.owner = owner
        self.date = newsfeed.date ?? 0
        self.text = newsfeed.text
        self.likes = newsfeed.likes
        self.comments = newsfeed.comments
        self.reposts = newsfeed.reposts
        //self.views = newsfeed.views
        self.attachments = newsfeed.attachments ?? []
    }
    
//    init(owner: Owner?, searchResult: SearchResultResponseClass) {
//        self.owner = owner
//        self.date = searchResult.date ?? 0
//        self.text = searchResult.text
//        self.likes = searchResult.likes
//        self.comments = searchResult.comments
//        self.reposts = searchResult.reposts
//        //self.views = newsfeed.views
//        self.attachments = searchResult.attachments ?? []
//    }
    
}
