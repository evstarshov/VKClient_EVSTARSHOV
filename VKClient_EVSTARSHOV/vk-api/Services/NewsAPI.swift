//
//  NewsAPI.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 15.11.2021.
//

import Foundation
import SwiftyJSON
import Alamofire

final class NewsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Account.shared.token
    let userId = Account.shared.userId
    let version = "5.81"
    
    func getNews(_ completion: @escaping (NewsJSON?) -> ()) {
        let method = "/newsfeed.get"
        let parametrs: Parameters = [
            "user_id": userId,
            "access_token": token,
            "start_time": 86400,
//            "start_from": 0,
//            "start_time": 5,
            "count": 3,
            "filters": "post,photo,photo_tag,wall_photo",
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parametrs).responseData { response in
            
            guard let data = response.data else {return}
            
            let decoder = JSONDecoder()
            let json = JSON(data)
            let dispatchGroup = DispatchGroup()
            
            let vkItemsJSON = json["response"]["items"].arrayValue
            let vkProfilesJSON = json["response"]["profiles"].arrayValue
            let vkGroupsJSON = json["response"]["groups"].arrayValue
            
            var vkItemsArr: [NewsItem] = []
            var vkProfilesArr: [NewsProfile] = []
            var vkGroupsArr: [NewsGroup] = []
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, items) in vkItemsJSON.enumerated() {
                    do {
                        let decodedItem = try decoder.decode(NewsItem.self, from: items.rawData())
                        vkItemsArr.append(decodedItem)
                    } catch (let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, profiles) in vkProfilesJSON.enumerated() {
                    do {
                        let decodedProfile = try decoder.decode(NewsProfile.self, from: profiles.rawData())
                        vkProfilesArr.append(decodedProfile)
                    } catch (let errorDecode) {
                        print("Profile decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, groups) in vkGroupsJSON.enumerated() {
                    do {
                        let decodedGroups = try decoder.decode(NewsGroup.self, from: groups.rawData())
                        vkGroupsArr.append(decodedGroups)
                    } catch (let errorDecode) {
                        print("Group decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                let response = NewsResponse(items: vkItemsArr, groups: vkGroupsArr, profiles: vkProfilesArr)
                let feed = NewsJSON(response: response)
                completion(feed)
            }
        }
        
    }
    
}


