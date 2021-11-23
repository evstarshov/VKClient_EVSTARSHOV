//
//  FriendsDB.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 15.11.2021.
//

import Foundation
import RealmSwift


final class FriendDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }
    
    func save(_ items: [FriendModel]) {
        let realm = try! Realm()
        
        do {
            try! realm.write {
                realm.add(items)
            }
        }
    }
    
    func load() -> Results<FriendModel> {
        
        let realm = try! Realm()
        
        let friends: Results<FriendModel> = realm.objects(FriendModel.self)
        
        return friends
        
    }
    
    func delete(_ items: [FriendModel]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(items)
        }
    }
}
