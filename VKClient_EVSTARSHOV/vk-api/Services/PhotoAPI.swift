//
//  PhotoAPI.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 22.10.2021.
//

import Foundation
import Alamofire


final class PhotoAPI {
    
    let baseURL = "https://api.vk.com/method"
    let token = Account.shared.token
    let userId = Account.shared.userId
    let album = "profile"
    let version = "5.81"
    let photoId = ""
    
    func getPhotos(completion: @escaping([PhotoModel]) -> ()) {
        let method = "/photos.get"
        let parameters: Parameters = [
            "owner_id": userId,
            "album_id": album,
            "extended": 1,
            "count": 10,
            "no_service_albums": 0,
            "access_token": token,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON as Any)
            
            do {
                
                let photoJSON = try JSONDecoder().decode(PhotoJSON.self, from: data)
                let myalbums: [PhotoModel] = photoJSON.response.items
                completion(myalbums)
                
            } catch {
                print(error)
            }
        }
    }
}
