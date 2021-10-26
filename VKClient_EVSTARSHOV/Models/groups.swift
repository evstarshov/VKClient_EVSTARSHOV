//
//  groups.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit
import Alamofire
import Foundation

// MARK: - Welcome
struct GroupsJSON: Codable {
    let response: GroupsResponse
}

// MARK: - Response
struct GroupsResponse: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let id, isClosed, isAdvertiser: Int
    let type: TypeEnum
    let adminLevel: Int?
    let isMember: Int
    let city: City?
    let photo50, photo200: String
    let isAdmin: Int
    let photo100: String
    let name, screenName: String

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

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

enum TypeEnum: String, Codable {
    case page = "page"
}


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
