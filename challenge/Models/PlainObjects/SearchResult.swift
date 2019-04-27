//
//  SearchResult.swift
//  challenge
//
//  Created by Oscar on 11/12/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

// To parse the JSON, add this file to your project and do:
//
//   let searchResult = try? newJSONDecoder().decode(SearchResult.self, from: jsonData)

import Foundation

struct SearchResult: Codable {
    let response: [SearchResultResponseElement]?
}

enum SearchResultResponseElement: Codable {
    case integer(Int)
    case searchResultResponseClass(SearchResultResponseClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(SearchResultResponseClass.self) {
            self = .searchResultResponseClass(x)
            return
        }
        throw DecodingError.typeMismatch(SearchResultResponseElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SearchResultResponseElement"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .searchResultResponseClass(let x):
            try container.encode(x)
        }
    }
}

struct SearchResultResponseClass: Codable {
    let id, date, ownerID, fromID: Int?
    let user: SearchResultUser?
    let postType: SearchResultPostType?
    let text: String?
    let attachment: SearchResultAttachment?
    let attachments: [SearchResultAttachment]?
    let postSource: SearchResultPostSource?
    let comments: SearchResultComments?
    let likes: SearchResultLikes?
    let reposts: SearchResultReposts?
    let group: SearchResultGroup?
    let markedAsAds, copyPostDate: Int?
    let copyPostType: SearchResultPostType?
    let copyOwnerID, copyPostID: Int?
    let copyText: String?
    let signerID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case ownerID = "owner_id"
        case fromID = "from_id"
        case user
        case postType = "post_type"
        case text, attachment, attachments
        case postSource = "post_source"
        case comments, likes, reposts, group
        case markedAsAds = "marked_as_ads"
        case copyPostDate = "copy_post_date"
        case copyPostType = "copy_post_type"
        case copyOwnerID = "copy_owner_id"
        case copyPostID = "copy_post_id"
        case copyText = "copy_text"
        case signerID = "signer_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.date = try container.decodeIfPresent(Int.self, forKey: .date)
        self.ownerID = try container.decodeIfPresent(Int.self, forKey: .ownerID)
        self.fromID = try container.decodeIfPresent(Int.self, forKey: .fromID)
        self.user = try container.decodeIfPresent(SearchResultUser.self, forKey: .user)
        self.postType = try container.decodeIfPresent(SearchResultPostType.self, forKey: .postType)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.attachment = try container.decodeIfPresent(SearchResultAttachment.self, forKey: .attachment)
        self.attachments = try container.decodeIfPresent([SearchResultAttachment].self, forKey: .attachments)
        self.postSource = try container.decodeIfPresent(SearchResultPostSource.self, forKey: .postSource)
        self.comments = try container.decodeIfPresent(SearchResultComments.self, forKey: .comments)
        self.likes = try container.decodeIfPresent(SearchResultLikes.self, forKey: .likes)
        self.reposts = try container.decodeIfPresent(SearchResultReposts.self, forKey: .reposts)
        self.group = try container.decodeIfPresent(SearchResultGroup.self, forKey: .group)
        self.markedAsAds = try container.decodeIfPresent(Int.self, forKey: .markedAsAds)
        self.copyPostDate = try container.decodeIfPresent(Int.self, forKey: .copyPostDate)
        self.copyPostType = try container.decodeIfPresent(SearchResultPostType.self, forKey: .copyPostType)
        self.copyOwnerID = try container.decodeIfPresent(Int.self, forKey: .copyOwnerID)
        self.copyPostID = try container.decodeIfPresent(Int.self, forKey: .copyPostID)
        self.copyText = try container.decodeIfPresent(String.self, forKey: .copyText)
        self.signerID = try container.decodeIfPresent(Int.self, forKey: .signerID)
    }
}

struct SearchResultAttachment: Codable {
    let type: SearchResultAttachmentType?
    let photo: SearchResultPhoto?
    let link: SearchResultLink?
    let audio: SearchResultAudio?
}

struct SearchResultAudio: Codable {
    let aid, ownerID: Int?
    let artist, title: String?
    let duration: Int?
    let url: String?
    let performer: String?
    let lyricsID, genre: Int?
    
    enum CodingKeys: String, CodingKey {
        case aid
        case ownerID = "owner_id"
        case artist, title, duration, url, performer
        case lyricsID = "lyrics_id"
        case genre
    }
}

struct SearchResultLink: Codable {
    let url: String?
    let title, description: String?
    let target: SearchResultTarget?
    let imageSrc, imageBig: String?
    
    enum CodingKeys: String, CodingKey {
        case url, title, description, target
        case imageSrc = "image_src"
        case imageBig = "image_big"
    }
}

enum SearchResultTarget: String, Codable {
    case targetInternal = "internal"
}

struct SearchResultPhoto: Codable {
    let pid, aid, ownerID: Int?
    let src, srcBig, srcSmall, srcXbig: String?
    let srcXxbig: String?
    let width, height: Int?
    let text: String?
    let created: Int?
    let accessKey: String?
    let userID, postID: Int?
    let srcXxxbig: String?
    
    enum CodingKeys: String, CodingKey {
        case pid, aid
        case ownerID = "owner_id"
        case src
        case srcBig = "src_big"
        case srcSmall = "src_small"
        case srcXbig = "src_xbig"
        case srcXxbig = "src_xxbig"
        case width, height, text, created
        case accessKey = "access_key"
        case userID = "user_id"
        case postID = "post_id"
        case srcXxxbig = "src_xxxbig"
    }
}

enum SearchResultAttachmentType: String, Codable {
    case audio = "audio"
    case link = "link"
    case photo = "photo"
}

struct SearchResultComments: Codable {
    let count, canPost: Int?
    let groupsCanPost: Bool?
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

enum SearchResultPostType: String, Codable {
    case copy = "copy"
    case post = "post"
}

struct SearchResultGroup: Codable {
    let gid: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: SearchResultGroupType?
    let photo, photoMedium, photoBig: String?
    
    enum CodingKeys: String, CodingKey {
        case gid, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type, photo
        case photoMedium = "photo_medium"
        case photoBig = "photo_big"
    }
}

enum SearchResultGroupType: String, Codable {
    case group = "group"
    case page = "page"
}

struct SearchResultLikes: Codable {
    let count, userLikes, canLike, canPublish: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

struct SearchResultPostSource: Codable {
    let type: SearchResultPostSourceType?
    let platform, data: String?
}

enum SearchResultPostSourceType: String, Codable {
    case api = "api"
    case mvk = "mvk"
    case rss = "rss"
    case vk = "vk"
}

struct SearchResultReposts: Codable {
    let count, userReposted: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

struct SearchResultUser: Codable {
    let uid: Int?
    let firstName, lastName: String?
    let sex: Int?
    let screenName: String?
    let photo, photoMediumRec: String?
    let online: Int?
    let onlineApp: String?
    let onlineMobile: Int?
    
    enum CodingKeys: String, CodingKey {
        case uid
        case firstName = "first_name"
        case lastName = "last_name"
        case sex
        case screenName = "screen_name"
        case photo
        case photoMediumRec = "photo_medium_rec"
        case online
        case onlineApp = "online_app"
        case onlineMobile = "online_mobile"
    }
}
