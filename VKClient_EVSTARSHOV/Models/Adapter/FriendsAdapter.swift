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
    private var friendAdapterList: [FriendsAdapterStruct] = []
    private var friendList: [FriendModel] = []
    
    
    func getFriends(completion: @escaping ([FriendsAdapterStruct])-> ()) {
        
        
        friendsService.getFriends { [weak self] friende in
            print("setting friendList")
            self?.friendList = friende
            print("friendList finished")
            
            for friends in self!.friendList {
                print("Appending Adapter Array")
                self?.friendAdapterList.append(self?.friend(from: friends) ?? FriendsAdapterStruct(id: 1, lastName: "", firstName: "", photo100: ""))
                completion(self!.friendAdapterList)
            }
            
        }
        
    }
    private func friend(from rlmFriend: FriendModel) -> FriendsAdapterStruct {
        return FriendsAdapterStruct(id: rlmFriend.id, lastName: rlmFriend.lastName, firstName: rlmFriend.firstName, photo100: rlmFriend.photo100)
    }
}

