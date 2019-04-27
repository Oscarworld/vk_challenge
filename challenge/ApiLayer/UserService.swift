//
//  UserApi.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

protocol UserServiceProtocol {
    
    func getUser(completion: @escaping (UserResponse?) -> ())
    
}

class UserService: UserServiceProtocol {
    
    private let defaultSession = URLSession(configuration: .default)
    
    private var dataTask: URLSessionDataTask?
    
    func getUser(completion: @escaping (UserResponse?) -> ()) {
        
        dataTask?.cancel()
        
        let path = ApiMethodPath.userGet.combinedPath
        var parameters: [String: String] = [
            "fields": "photo_50",
            "version": "5.87"
        ]
        
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
                if let users = try? JSONDecoder().decode(UserResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completion(users)
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
