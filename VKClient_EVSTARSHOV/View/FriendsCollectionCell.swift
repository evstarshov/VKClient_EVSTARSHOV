//
//  FriendsCollectionCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 31.08.2021.
//

import UIKit

class FriendsCollectionCell: UICollectionViewCell {

    @IBOutlet var friendsLabel: UILabel!
    @IBOutlet var friendsImageView: UIImageView!
    @IBOutlet var groupLabel: UILabel!
    
    
    func configure(with friends: Friends){
        friendsLabel.text = friends.name
        friendsImageView.image = friends.image
        groupLabel.text = friends.groups
        contentMode = .scaleAspectFill
    }
}
