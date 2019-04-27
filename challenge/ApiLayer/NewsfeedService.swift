//
//  NewsfeedApi.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

protocol NewsfeedServiceProtocol {
    
    func getNewsfeed(count: Int, startFrom: String?, completion: @escaping (Newsfeed?) -> ())
    
    func searchNewsfeed(query: String, count: Int, startFrom: String?, completion: @escaping (SearchResult?) -> ())
    
}

class NewsfeedService: NewsfeedServiceProtocol {
    
    private let defaultSession = URLSession(configuration: .default)
    
    private var dataTask: URLSessionDataTask?
    
    func getNewsfeed(count: Int, startFrom: String?, completion: @escaping (Newsfeed?) -> ()) {
        
        dataTask?.cancel()
        
        let path = ApiMethodPath.newsfeedGet.combinedPath
        var parameters: [String: String] = [
            "filter": "post",
            "count": "\(count)",
            "version": "5.87"
        ]
        
        if let startFrom = startFrom {
            parameters["start_from"] = startFrom
        }
        
        if let accessToken = ApiService.shared.accessToken {
            parameters["access_token"] = accessToken
        }
        
        guard let url = ApiService.createURL(path, parameters: parameters) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                if let newsfeeds = try? JSONDecoder().decode(Newsfeed.self, from: data) {
                    DispatchQueue.main.async {
                        completion(newsfeeds)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            
            self?.dataTask = nil
        }
        
        dataTask?.resume()
    }
    
    func searchNewsfeed(query: String, count: Int, startFrom: String?, completion: @escaping (SearchResult?) -> ()) {
        
        dataTask?.cancel()
        
        let path = ApiMethodPath.newsfeedSearch.combinedPath
        
        var parameters: [String: String] = [
            "q": query,
            "count": "\(count)",
            "extended": "1",
            "version": "5.87"
        ]
        
        if let startFrom = startFrom {
            parameters["start_from"] = startFrom
        }
        
        if let accessToken = ApiService.shared.accessToken {
            parameters["access_token"] = accessToken
        }
        
        guard let url = ApiService.createURL(path, parameters: parameters) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                if let newsfeeds = try? JSONDecoder().decode(SearchResult.self, from: data) {
                    DispatchQueue.main.async {
                        completion(newsfeeds)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            
            self?.dataTask = nil
        }
        
        dataTask?.resume()
    }
}
