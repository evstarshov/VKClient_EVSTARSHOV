//
//  Account.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 18.10.2021.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift


final class Account {
    
    private init() {}
    
    static let shared = Account()
    
    var token: String {
            set {
                KeychainWrapper.standard.set(newValue, forKey: "userId")
            }
            get {
                return KeychainWrapper.standard.string(forKey:"userId") ?? ""
            }
    }
    var userId: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
        get {
            return UserDefaults.standard.integer(forKey:"userId")
        }
    }
    
    let clientID = "8018451"
    let version = "5.81"
}
