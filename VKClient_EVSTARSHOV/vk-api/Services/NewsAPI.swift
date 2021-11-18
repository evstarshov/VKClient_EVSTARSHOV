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
    
    func getNews(completion: @escaping([NewsFeedModel]) -> ()) {
        let method = "/newsfeed.get"
        let parametrs: Parameters = [
            "user_id": userId,
            "access_token": token,
            "start_time": 86400,
            "count": 5,
            "filters": "post,photo,photo_tag,wall_photo",
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parametrs).responseJSON { response in
            
            guard let data = response.data else { return }
                         debugPrint(response.data?.prettyJSON as Any)
            
            do {
                let items = try JSON(data)["response"]["groups"].rawData()
                let news = try? JSONDecoder().decode([NewsFeedModel].self, from: items)
                                 completion(news ?? [])
                             } catch {
                                 print(error)
                             }
            
        }
        
    }
    
}


