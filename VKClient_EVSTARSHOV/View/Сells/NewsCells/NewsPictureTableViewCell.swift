//
//  NewsPictureTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.11.2021.
//

import UIKit

class NewsPictureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var newsPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
