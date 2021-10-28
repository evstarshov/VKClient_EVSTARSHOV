//
//  groups.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit

struct Groups {
    let groupname: String
    let groupimage: UIImage?
}


var groupsArray = [
    Groups(groupname: "Спортсменки", groupimage: UIImage(named: "Спортсменка")),
    Groups(groupname: "Славянки", groupimage: UIImage(named: "Славянка")),
    Groups(groupname: "Отличницы", groupimage: UIImage(named: "Отличница"))
]

extension Groups: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.groupname == rhs.groupname && lhs.groupimage == rhs.groupimage
    }
}
