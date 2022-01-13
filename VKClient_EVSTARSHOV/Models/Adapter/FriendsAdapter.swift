//
//  NewsAdapter.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 12.01.2022.
//

import Foundation
import RealmSwift


struct FriendsAdapterStruct {
    let id: Int
    let lastName: String
    let firstName: String
    let photo100: String
}


final class FriendsAdapter {
    private let friendsService = FriendsAPI()
    private var realmNotificationTokens: [String: NotificationToken] = [:]
    
    func getFriends(inName lastName: String, then completion: @escaping ([FriendsAdapterStruct]) -> Void) {
        guard let realm = try? Realm(),
              let realmName = realm.object(ofType: FriendModel.self, forPrimaryKey: lastName) else { return }
        
        
        //let token = realmName.
        
    }
}
