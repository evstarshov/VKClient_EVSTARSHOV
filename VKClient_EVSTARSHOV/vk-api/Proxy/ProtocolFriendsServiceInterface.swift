//
//  ProtocolFriendsServiceInterface.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 25.01.2022.
//

import Foundation


protocol FriendsServiceInterface {
    func getFriends(completion: @escaping ([FriendsAdapterStruct])-> ())
}



class FriendsServiceProxy: FriendsServiceInterface {

    
    
    let friendsService: FriendsAdapter
    
    
    init(friendsService: FriendsAdapter) {
        self.friendsService = friendsService
    }
    

    
    func getFriends(completion: @escaping ([FriendsAdapterStruct])-> ()) {

        
        self.friendsService.getFriends(completion: completion)
        print("Called func getWeathers")
        
    }
}
