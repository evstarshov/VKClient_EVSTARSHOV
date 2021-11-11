//
//  groups.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit
import RealmSwift


// MARK: - Welcome
struct GroupsJSON: Codable {
    let response: GroupsResponse
}

// MARK: - Response
struct GroupsResponse: Codable {
    let count: Int
    let items: [GroupModel]
}

// MARK: - Item
class GroupModel: Object, Codable {
    @objc dynamic var id, isClosed, isAdvertiser: Int
    let type: TypeEnum
    let adminLevel: Int?
    @objc dynamic var isMember: Int
    let city: City?
    @objc dynamic var photo50, photo200: String
    @objc dynamic var isAdmin: Int
    @objc dynamic var photo100: String
    @objc dynamic var name, screenName: String

    enum CodingKeys: String, CodingKey {
        case id
        case isClosed = "is_closed"
        case isAdvertiser = "is_advertiser"
        case type
        case adminLevel = "admin_level"
        case isMember = "is_member"
        case city
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case isAdmin = "is_admin"
        case photo100 = "photo_100"
        case name = "name"
        case screenName = "screen_name"
    }
}

final class GroupDB {
    
    let migration = Realm.Configuration(schemaVersion: 6) //миграция работает как на расширение так и на уделение
    lazy var mainRealm = try! Realm(configuration: migration)
    
    
    func create(_ groups: [GroupModel]) {
        mainRealm.beginWrite()
        do {
            mainRealm.add(groups) //добавляем объект в хранилище
            try mainRealm.commitWrite()
            print(mainRealm.configuration.fileURL ?? "")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [GroupModel] {
        let groups = mainRealm.objects(GroupModel.self)
        groups.forEach { print($0.name) }
        print(mainRealm.configuration.fileURL ?? "")
        return Array(groups) //враппим Result<> в Array<>
    }
    
    func delete(_ groups: [GroupModel]) {
        do {
            mainRealm.beginWrite()
            mainRealm.delete(groups)
            try mainRealm.commitWrite()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func update(_ groups: [GroupModel]) {
        do {
            let oldGroups =  mainRealm.objects(GroupModel.self).filter("id == %@", groups)
            mainRealm.beginWrite()
            mainRealm.delete(oldGroups)
            mainRealm.add(groups)
            try mainRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

enum TypeEnum: String, Codable {
    case page = "page"
}

// Тестовые данные

struct Groups {
    let groupname: String
    let groupimage: UIImage?
}


var groupsArray = [
    Groups(groupname: "Спортсменки", groupimage: UIImage(named: "Спортсменка")),
    Groups(groupname: "Славянки", groupimage: UIImage(named: "Славянка")),
    Groups(groupname: "Отличницы", groupimage: UIImage(named: "Отличница"))
]

extension Groups: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.groupname == rhs.groupname && lhs.groupimage == rhs.groupimage
    }
}
