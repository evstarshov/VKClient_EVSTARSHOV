//
//  NewsLikesTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.11.2021.
//

import UIKit

class NewsLikesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var repostBtn: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(likes: String?, comments: String?,
                   reposts: String?, views: String?) {
        if let likes = likes {
            likesLabel.text = likes
        }
        if let comments = comments {
            commentsLabel.text = comments
        }
        if let reposts = reposts {
            repostLabel.text = reposts
        }
        if let views = views {
            viewsLabel.text = views
        }
    }
    
}
