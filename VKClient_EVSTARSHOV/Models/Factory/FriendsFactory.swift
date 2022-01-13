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
    let friendAvatar: AvatarImage!
}


final class FriendViewModelFactory {
    func constructViewModels(from friends: [FriendsAdapterStruct]) -> [FriendViewModel] {
        return friends.compactMap(self.viewModel)
    }
    
    private func viewModel(from friend: FriendsAdapterStruct) -> FriendViewModel {
        let friendName = String(friend.firstName + " " + friend.lastName)
        let avatar = AvatarImage()
        let friendAvatar = friend.photo100
        if let imageURL = URL(string: friendAvatar) {
            avatar.loadImage(url: imageURL)
        }
        return FriendViewModel(friendName: friendName, friendAvatar: avatar)
    }
}
