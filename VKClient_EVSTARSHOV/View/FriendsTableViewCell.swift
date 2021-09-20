//
//  FriendsTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet var friendImageAvatar: AvatarImage!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendGroupLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure(friend: Friends) {
        friendImageAvatar.image = friend.image
//        friendGroupImage.image = nil
        friendNameLabel.text = friend.name + friend.secondname
        friendGroupLabel.text = friend.groups
        contentMode = .scaleAspectFill
    }
}
