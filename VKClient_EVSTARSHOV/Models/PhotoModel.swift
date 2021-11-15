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
    @objc dynamic var date, ownerID, postID: Int
    @objc dynamic var text: String
    @objc dynamic var hasTags: Bool
    @objc dynamic var albumID, canComment: Int
    @objc dynamic var assetUrl: String = ""
    
    let comments: PhotoComments
    let likes: Likes
    let reposts, tags: PhotoComments
    let sizes: [Size]
    
    var photoUrl: String {
        guard let size = sizes.last else { return ""}
        return size.url
    }

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

final class PhotosDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }

    func add(_ items: [PhotoModel]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
    }
    
    func load() -> Results<PhotoModel> {
        let realm = try! Realm()
        let photos: Results<PhotoModel> = realm.objects(PhotoModel.self)
        return photos
    }
    
    func delete(_ item: PhotoModel) {
        let realm = try! Realm()
        
        //Асинхронное API
        try! realm.write {
            realm.delete(item)
        }
    }
    
    func deleteAll() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
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
    let url: String
    let type: String
}
