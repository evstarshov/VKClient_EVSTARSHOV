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
    
    let migration = Realm.Configuration(schemaVersion: 6) //миграция работает как на расширение так и на уделение
    lazy var mainRealm = try! Realm(configuration: migration)
    
    func create(_ photos: [PhotoModel]) {
        mainRealm.beginWrite()
        do {
            mainRealm.add(photos) //добавляем объект в хранилище
            try mainRealm.commitWrite()
            print(mainRealm.configuration.fileURL ?? "")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [PhotoModel] {
        
        let photos = mainRealm.objects(PhotoModel.self)
        photos.forEach { print($0.id) }
        print(mainRealm.configuration.fileURL ?? "")
        return Array(photos) //враппим Result<> в Array<>
    }
    
    func delete(_ photos: [PhotoModel]) {
        do {
            mainRealm.beginWrite()
            mainRealm.delete(photos)
            try mainRealm.commitWrite()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(_ photos: [PhotoModel]) {
        do {
            let oldPhotos =  mainRealm.objects(PhotoModel.self).filter("id == %@", photos)
            mainRealm.beginWrite()
            mainRealm.delete(oldPhotos)
            mainRealm.add(photos)
            try mainRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
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
