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
    let method = "/newsfeed.get"
    
    var parametrs: Parameters
    
    init() {
        let session = Account.shared
        self.parametrs = [
            "client_id": session.clientID,
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
            "filters": "post",
            "count": "50",
        ]
    }

    
    func getNews(startTime: TimeInterval? = nil, startFrom: String? = nil, _ completion: @escaping (NewsJSON?) -> ()) {
        

        
        let url = baseUrl + method
        
        if startTime != nil {
            self.parametrs["start_time"] = startTime
        }
        
        if startFrom != nil {
            self.parametrs["start_from"] = startFrom
        }
        
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


