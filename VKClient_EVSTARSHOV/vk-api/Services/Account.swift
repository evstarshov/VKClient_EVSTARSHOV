//
//  Account.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 18.10.2021.
//

import UIKit

final class Account {
    
    private init() {}
    
    static let shared = Account()
    
    var token = ""
    var userId = ""
}
