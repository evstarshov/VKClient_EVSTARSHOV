//
//  NewsAuthorTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.11.2021.
//

import UIKit

protocol ViewModel {
 
    var avatar: String { get }
    var label: String { get }
    
    
}

final class AuthorCellModel: ViewModel {
    
    var avatar: String = ""
    
    var label: String = ""
    
    
    
    init (avatar: String, label: String) {
    
    self.avatar = avatar
    self.label = label
        
    }
}

class NewsAuthorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorAvatar: AvatarImage!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureAuthor(model: AuthorCellModel) {
                
        if let image = URL(string: model.avatar) {
            authorAvatar?.loadImage(url: image)
        }
        contentMode = .scaleAspectFill
        
        authorNameLabel.text? = model.label
        
    }
           
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
