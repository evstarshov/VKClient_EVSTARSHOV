//
//  GroupsAPI.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 22.10.2021.
//

import Foundation
import Alamofire
import PromiseKit
import RealmSwift

final class GroupsAPI {
    
    let baseURL = "https://api.vk.com/method"
    let token = Account.shared.token
    let userId = Account.shared.userId
    let version = "5.81"
    
    func getGroups(completion: @escaping([GroupModel]) -> ()) {
        let method = "/groups.get"
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "access_token": token,
            "fields": "name, photo_100",
            "count": 10,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON as Any)
            
            do {
                
                let GroupsJSON = try JSONDecoder().decode(GroupsJSON.self, from: data)
                let mygroups: [GroupModel] = GroupsJSON.response.items
                completion(mygroups)
                
            } catch {
                print(error)
            }
        }
    }
}


enum ApplicationError: Error {
    case noGroups
    case noPosts
    case groupsCouldNotBeParsed
}

final class GroupsAPIPromisekit {
    
    func getAllGroups() -> Promise<[GroupModel]> {
        
        return Promise<[GroupModel]> { resolver in
        
        let baseURL = "https://api.vk.com/method"
        let token = Account.shared.token
        let userId = Account.shared.userId
        let version = "5.81"
        let method = "/groups.get"
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "access_token": token,
            "fields": "name, photo_100",
            "count": 10,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            if let error = response.error {
                resolver.reject(error)
            }
            
                
            if let data = response.data {
                do {
                    let groups = try JSONDecoder().decode(GroupsJSON.self, from: data).response.items
                    resolver.fulfill(groups)
                } catch {
                    resolver.reject(ApplicationError.noGroups)
                }
            }
        
            }
            
        }
    
    }
    
    
}


//final class GroupsRealmPromisekit {
//    
//    private let groupsDB = GroupDB()
//    private var mygroups: Results<GroupModel>?
//    private var token: NotificationToken?
//    
//    func writeGroups(groups: GroupsAPIPromisekit) -> Promise<Results<GroupModel>?> {
//        return Promise<Results<GroupModel>?> { resolve in
//            
//            self.
//            
//            
//        }
//    }
//    
//}
//}
