//
//  FriendsFactory.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 13.01.2022.
//

import Foundation
import UIKit


struct FriendViewModel {
    let friendName: String
    let friendAvatar: String
}


final class FriendViewModelFactory {
    func constructViewModels(from friends: [FriendsAdapterStruct]) -> [FriendViewModel] {
        return friends.compactMap(self.viewModel)
    }
    
    private func viewModel(from friend: FriendsAdapterStruct) -> FriendViewModel {
        let friendName = String(friend.firstName + " " + friend.lastName)
        let avatarURL = String(friend.photo100)
        
        return FriendViewModel(friendName: friendName, friendAvatar: avatarURL)
    }
}
