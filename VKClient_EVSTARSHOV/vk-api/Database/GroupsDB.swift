//
//  GroupsDB.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 15.11.2021.
//

import Foundation
import RealmSwift

final class GroupDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }
    
    func save(_ items: [GroupModel]) {
        let realm = try! Realm()
        
        do {
            try! realm.write {
                realm.add(items)
            }
        }
    }
    
    func load() -> Results<GroupModel> {
        
        let realm = try! Realm()
        
        let groups: Results<GroupModel> = realm.objects(GroupModel.self)
        
        return groups
        
    }
    
    func delete(_ items: [GroupModel]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(items)
        }
    }
    
}
