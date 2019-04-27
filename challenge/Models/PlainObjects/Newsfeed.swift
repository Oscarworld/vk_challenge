//
//  NewsfedPlainObject.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.

import Foundation

struct Newsfeed: Codable {
    let response: NewsfeedResponse?
}

struct NewsfeedResponse: Codable {
    let items: [NewsfeedItem]?
    let profiles: [NewsfeedProfile]?
    let groups: [NewsfeedGroup]?
    let newOffset: Int?
    let newFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case newOffset = "new_offset"
        case newFrom = "new_from"
    }
}

struct NewsfeedGroup: Codable {
    let gid: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
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

struct NewsfeedItem: Codable {
    let type: NewsfeedItemType?
    let sourceID, date: Int?
    let audio: [NewsfeedAudioElement]?
    let postID: Int?
    let postType: NewsfeedPostType?
    let text: String?
    let markedAsAds: Int?
    let attachment: NewsfeedAttachment?
    let attachments: [NewsfeedAttachment]?
    let postSource: NewsfeedPostSource?
    let comments: NewsfeedItemComments?
    let likes: NewsfeedItemLikes?
    let reposts: NewsfeedReposts?
    let photos: [NewsfeedPhotoElement]?
    let signerID: Int?
    let friends: [NewsfeedFriendElement]?
    let copyPostDate: Int?
    let copyPostType: NewsfeedPostType?
    let copyOwnerID, copyPostID: Int?
    let video: [NewsfeedVideoElement]?
    let finalPost: Int?
    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceID = "source_id"
        case date, audio
        case postID = "post_id"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachment, attachments
        case postSource = "post_source"
        case comments, likes, reposts, photos
        case signerID = "signer_id"
        case friends
        case copyPostDate = "copy_post_date"
        case copyPostType = "copy_post_type"
        case copyOwnerID = "copy_owner_id"
        case copyPostID = "copy_post_id"
        case video
        case finalPost = "final_post"
    }
}

struct NewsfeedAttachment: Codable {
    let type: NewsfeedAttachmentType?
    let link: NewsfeedLink?
    let photo: NewsfeedPhotoClass?
    let video: NewsfeedVideoClass?
}

struct NewsfeedLink: Codable {
    let url: String?
    let title, description: String?
    let target: NewsfeedTarget?
    let imageSrc, imageBig: String?
    let buttonText, buttonAction: String?
    
    enum CodingKeys: String, CodingKey {
        case url, title, description, target
        case imageSrc = "image_src"
        case imageBig = "image_big"
        case buttonText = "button_text"
        case buttonAction = "button_action"
    }
}

enum NewsfeedTarget: String, Codable {
    case targetInternal = "internal"
}

struct NewsfeedPhotoClass: Codable {
    let pid, aid, ownerID, userID: Int?
    let src, srcBig, srcSmall, srcXbig: String?
    let srcXxbig: String?
    let width, height: Int?
    let text: String?
    let created: Int?
    let accessKey: String?
    let srcXxxbig: String?
    let postID: Int?
    let likes: NewsfeedPhotoLikes?
    let reposts: NewsfeedReposts?
    let comments: NewsfeedPhotoComments?
    let canComment, canRepost: Int?
    
    enum CodingKeys: String, CodingKey {
        case pid, aid
        case ownerID = "owner_id"
        case userID = "user_id"
        case src
        case srcBig = "src_big"
        case srcSmall = "src_small"
        case srcXbig = "src_xbig"
        case srcXxbig = "src_xxbig"
        case width, height, text, created
        case accessKey = "access_key"
        case srcXxxbig = "src_xxxbig"
        case postID = "post_id"
        case likes, reposts, comments
        case canComment = "can_comment"
        case canRepost = "can_repost"
    }
}

struct NewsfeedPhotoComments: Codable {
    let count: Int?
}

struct NewsfeedPhotoLikes: Codable {
    let userLikes, count: Int?
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

struct NewsfeedReposts: Codable {
    let count, userReposted: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

enum NewsfeedAttachmentType: String, Codable {
    case album = "album"
    case audio = "audio"
    case link = "link"
    case photo = "photo"
    case video = "video"
}

struct NewsfeedVideoClass: Codable {
    let vid, ownerID: Int?
    let title: String?
    let duration: Int?
    let description: String?
    let date, views: Int?
    let image, imageBig, imageSmall: String?
    let accessKey: String?
    let videoRepeat: Int?
    let firstFrame320, firstFrame160, firstFrame130, firstFrame1280: String?
    let firstFrame800: String?
    let canComment, canRepost: Int?
    let likes: NewsfeedPhotoLikes?
    let reposts: NewsfeedReposts?
    
    enum CodingKeys: String, CodingKey {
        case vid
        case ownerID = "owner_id"
        case title, duration, description, date, views, image
        case imageBig = "image_big"
        case imageSmall = "image_small"
        case accessKey = "access_key"
        case videoRepeat = "repeat"
        case firstFrame320 = "first_frame_320"
        case firstFrame160 = "first_frame_160"
        case firstFrame130 = "first_frame_130"
        case firstFrame1280 = "first_frame_1280"
        case firstFrame800 = "first_frame_800"
        case canComment = "can_comment"
        case canRepost = "can_repost"
        case likes, reposts
    }
}

enum NewsfeedAudioElement: Codable {
    case integer(Int)
    case newsfeedAudioClass(NewsfeedAudioClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(NewsfeedAudioClass.self) {
            self = .newsfeedAudioClass(x)
            return
        }
        throw DecodingError.typeMismatch(NewsfeedAudioElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for NewsfeedAudioElement"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .newsfeedAudioClass(let x):
            try container.encode(x)
        }
    }
}

struct NewsfeedAudioClass: Codable {
    let aid, ownerID: Int?
    let artist, title: String?
    let duration: Int?
    let url: String?
    let lyricsID, genre: Int?
    
    enum CodingKeys: String, CodingKey {
        case aid
        case ownerID = "owner_id"
        case artist, title, duration, url
        case lyricsID = "lyrics_id"
        case genre
    }
}

struct NewsfeedItemComments: Codable {
    let count, canPost: Int?
    let groupsCanPost: Bool?
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

enum NewsfeedPostType: String, Codable {
    case copy = "copy"
    case post = "post"
}

enum NewsfeedFriendElement: Codable {
    case integer(Int)
    case newsfeedFriendClass(NewsfeedFriendClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(NewsfeedFriendClass.self) {
            self = .newsfeedFriendClass(x)
            return
        }
        throw DecodingError.typeMismatch(NewsfeedFriendElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for NewsfeedFriendElement"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .newsfeedFriendClass(let x):
            try container.encode(x)
        }
    }
}

struct NewsfeedFriendClass: Codable {
    let uid: Int?
}

struct NewsfeedItemLikes: Codable {
    let count, userLikes, canLike, canPublish: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

enum NewsfeedPhotoElement: Codable {
    case integer(Int)
    case newsfeedPhotoClass(NewsfeedPhotoClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(NewsfeedPhotoClass.self) {
            self = .newsfeedPhotoClass(x)
            return
        }
        throw DecodingError.typeMismatch(NewsfeedPhotoElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for NewsfeedPhotoElement"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .newsfeedPhotoClass(let x):
            try container.encode(x)
        }
    }
}

struct NewsfeedPostSource: Codable {
    let type: NewsfeedPostSourceType?
    let platform: String?
    let url: String?
}

enum NewsfeedPostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum NewsfeedItemType: String, Codable {
    case audio = "audio"
    case friend = "friend"
    case post = "post"
    case video = "video"
    case wallPhoto = "wall_photo"
}

enum NewsfeedVideoElement: Codable {
    case integer(Int)
    case newsfeedVideoClass(NewsfeedVideoClass)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(NewsfeedVideoClass.self) {
            self = .newsfeedVideoClass(x)
            return
        }
        throw DecodingError.typeMismatch(NewsfeedVideoElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for NewsfeedVideoElement"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .newsfeedVideoClass(let x):
            try container.encode(x)
        }
    }
}

struct NewsfeedProfile: Codable {
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
