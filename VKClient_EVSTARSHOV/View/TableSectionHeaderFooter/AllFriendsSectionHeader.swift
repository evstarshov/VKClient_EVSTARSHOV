//
//  AllFriendsSectionHeader.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 07.09.2021.
//

import UIKit

class AllFriendsSectionHeader: UITableViewHeaderFooterView {

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = "textLabel"
        detailTextLabel?.text = "detailTextLabel"
    }

}
