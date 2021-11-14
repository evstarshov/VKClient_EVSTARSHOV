//
//  FriendFirebase.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 14.11.2021.
//

import Foundation
import Firebase
import FirebaseDatabase

class FriendsFirebase {

    let firstName: String
    let lastName: String

    let ref: DatabaseReference?
    
    init(firstName: String, lastName: String) {
        self.ref = nil
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard
            let value = snapshot.value as? [String: Any],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String
            
                
        else { return nil }
        
        self.ref = snapshot.ref
        self.firstName = firstName
        self.lastName = lastName
        
    }
    
    func toAnyObject() -> [AnyHashable: Any] {
        return
        ["firstName": firstName,
            "lastName": lastName
            ] as [AnyHashable: Any]
    }
    
}
