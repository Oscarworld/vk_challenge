//
//  UserPlainObject.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let response: [User]?
}

struct User: Codable {
    let id: Int?
    let firstName, lastName: String?
    let photo50: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
}
