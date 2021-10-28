//
//  FriendsAPI.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 22.10.2021.
//

import Foundation
import Alamofire

struct Friend {
    
}

// Получение списка друзей, запрос к серверу

final class FriendsAPI {
    
    let baseURL = "https://api.vk.com/method"
    let token = Account.shared.token
    let userId = Account.shared.userId
    let version = "5.81"
    
    func getFriends(completion: @escaping([Friend]) -> ()) {
        let method = "/friends.get"
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            
            "access_token": token,
            "fields": "photo_50, photo_100",
            "count": 10,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value)
        }
    }
}
