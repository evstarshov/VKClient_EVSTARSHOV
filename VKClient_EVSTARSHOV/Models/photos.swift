//
//  photos.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.10.2021.
//

import Foundation
import RealmSwift

// MARK: - Welcome
struct PhotoJSON: Codable {
    let response: PhotoResponse
}

// MARK: - Response
struct PhotoResponse: Codable {
    let count: Int
    let items: [PhotoDB]
}

// MARK: - Item
class PhotoDB: Object, Codable {
    @objc dynamic var id: Int
    let comments: PhotoComments
    let likes: Likes
    let reposts, tags: PhotoComments
    @objc dynamic var date, ownerID, postID: Int
    @objc dynamic var text: String
    let sizes: [Size]
    @objc dynamic var hasTags: Bool
    @objc dynamic var albumID, canComment: Int

    enum CodingKeys: String, CodingKey {
        case id, comments, likes, reposts, tags, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text, sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - Comments
struct PhotoComments: Codable {
    let count: Int
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: URL
    let type: String
}
