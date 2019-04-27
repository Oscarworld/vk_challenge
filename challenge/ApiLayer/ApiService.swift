//
//  File.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    var accessToken: String?
    
    static func createURL(_ url: String,
                       parameters: [String: String]) -> URL? {
        
        guard var components = URLComponents(string: url) else {
            return nil
        }
        
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        //components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        return components.url
    }
}
