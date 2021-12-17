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
    var date: Int { get }
    
}

final class AuthorCellModel: ViewModel {
    
    var avatar: String = ""
    
    var label: String = ""
    
    var date: Int = 0
    
    init (avatar: String, label: String, date: Int) {
        
        self.avatar = avatar
        self.label = label
        self.date = date
        
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
        
        let dateInt = Double(model.date)
        let date = Date(timeIntervalSince1970: dateInt)
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        print("Publication date is \(date)")
        dateLabel?.text = dateformatter.string(from: date)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
