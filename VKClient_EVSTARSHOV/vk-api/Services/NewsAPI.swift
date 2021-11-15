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
    
    func getNews(completion: @escaping([NewsJSON]) -> ()) {
        let method = "/newsfeed.get"
        let parametrs: Parameters = [
            "user_id": userId,
            "access_token": token,
            "start_time": 86400,
            "count": 1,
            "filters": "post,photo,photo_tag,wall_photo",
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parametrs).responseJSON { response in
            
            guard let data = response.data else { return }
                         debugPrint(response.data?.prettyJSON as Any)
            
            do {
                let itemsData = try JSON(data)["response"]["items"].rawData()
                                 let news = try JSONDecoder().decode([NewsJSON].self, from: itemsData)

                                 completion(news)

                             } catch {
                                 print(error)
                             }
            
        }
        
    }
    
}


