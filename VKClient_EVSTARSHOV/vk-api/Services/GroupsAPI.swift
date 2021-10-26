//
//  GroupsAPI.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 22.10.2021.
//

import Foundation
import Alamofire

final class GroupsAPI {
    let baseURL = "https://api.vk.com/method"
    let token = Account.shared.token
    let userId = Account.shared.userId
    let version = "5.81"
    
    func getGroups(completion: @escaping([Group]) -> ()) {
        let method = "/groups.get"
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            
            
            "access_token": token,
            "fields": "city, country, place, members_count, counters",
            "count": 10,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON as Any)
            
            do {
                
                let GroupsJSON = try JSONDecoder().decode(GroupsJSON.self, from: data)
                let groups: [Group] = GroupsJSON.response.groupItems
                completion(groups)
                
            } catch {
                print(error)
            }
        }
    }
}
