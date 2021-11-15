//
//  photos.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.10.2021.
//

import Foundation
import RealmSwift

// MARK: - Welcome
class PhotoModel: Object, Codable {
    
    //Записывается в Realm
    @objc dynamic var postID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var text: String = ""
    
    @objc dynamic var assetUrl: String = ""
    
    //Не сохраняется в Realm
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let likes: Likes
    let albumID: Int
    let reposts: Reposts

    //Большой картинки
    var photoUrl: String {
        guard let size = sizes.last else { return ""}
        return size.url
    }
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case reposts
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case likes
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
