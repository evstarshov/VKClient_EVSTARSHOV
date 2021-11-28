//
//  NewsAuthorTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.11.2021.
//

import UIKit

class NewsAuthorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorAvatar: UIImageView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureAuthor(authorModel: NewsJSON?) {
        
        if let image = URL(string: authorModel?.response.groups.last?.photo100 ?? "no image") {
            authorAvatar?.loadImage(url: image) }
        authorNameLabel?.text = authorModel?.response.groups.last?.name ?? "no text"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
