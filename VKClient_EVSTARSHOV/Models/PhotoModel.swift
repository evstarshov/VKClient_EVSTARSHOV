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
    let items: [PhotoModel]
}

// MARK: - Item
class PhotoModel: Object, Codable {
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

final class PhotoDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }
    
    func save(_ items: [PhotoModel]) {
        let realm = try! Realm()
        
        do {
            try! realm.write {
                realm.add(items)
            }
        }
    }
    
    func load() -> Results<PhotoModel> {
        
        let realm = try! Realm()
        
        let photos: Results<PhotoModel> = realm.objects(PhotoModel.self)
        
        return photos
        
    }
    
    func delete(_ items: [PhotoModel]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(items)
        }
    }
}
    

    // Тестовые данные

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
