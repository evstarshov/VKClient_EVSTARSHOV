//
//  PhotoAPI.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 22.10.2021.
//

import Foundation
import Alamofire

struct Photo {
    
}

final class PhotoAPI {
    
    let baseURL = "https://api.vk.com/method"
    let token = Account.shared.token
    let userId = Account.shared.userId
    let album = "profile"
    let version = "5.81"
    let photoId = ""
    
    func getPhotos(completion: @escaping([Photo]) -> ()) {
        let method = "/photos.get"
        let parameters: Parameters = [
            "owner_id": userId,
            "album_id": album,
            "photo_ids": photoId,
            
            "access_token": token,
            "extended": "photos.getAll",
            "count": 2,
            "v": version
        ]
        
        let url = baseURL + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print(response.value)
        }
    }
}
