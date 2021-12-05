//
//  FriendsOperation.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 05.12.2021.
//

import Foundation
import Alamofire

final class FriendsMakeAPIOperation: Operation {
    var data: Data?
    
    override func main() {
        var requesConstructor = URLComponents()
        requesConstructor.scheme = "https"
        requesConstructor.host = "api.vk.com"
        requesConstructor.path = "/method/friends.get"
        requesConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Account.shared.userId)"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_50,online"),
            URLQueryItem(name: "access_token", value: "\(Account.shared.token)"),
            URLQueryItem(name: "v", value: "5.81")
        ]
        
        guard let url = requesConstructor.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.data = data
    }
}
