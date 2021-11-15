//
//  PhotosDB.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 15.11.2021.
//

import Foundation
import RealmSwift

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
