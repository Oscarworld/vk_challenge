//
//  ApiMethods.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

class ApiCombiner {
    
    static let shared = ApiCombiner()
    
    lazy var api = "https://api.vk.com/method/"
    
    func combine(with path: String) -> String {
        return "\(api)\(path)"
    }
}

enum ApiMethodPath: String {
    
    case userGet = "users.get"
    
    case newsfeedGet = "newsfeed.get"
    case newsfeedSearch = "newsfeed.search"
}

extension ApiMethodPath {
    var combinedPath: String {
        return ApiCombiner.shared.combine(with: rawValue)
    }
}
