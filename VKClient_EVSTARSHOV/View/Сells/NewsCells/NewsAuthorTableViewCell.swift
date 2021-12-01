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
    
    @IBOutlet weak var authorAvatar: UIImageView!
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
        dateformatter.dateStyle = .full
        print("Publication date is \(date)")
        dateLabel?.text = dateformatter.string(from: date)
        
        
        
//        if let image = URL(string: authorModel.response.groups[0].photo100 ?? "no image") {
//            authorAvatar?.loadImage(url: image) }
//        authorNameLabel?.text = authorModel?.response.groups[0].name ?? "no text"
//
//                let dateInt = Double(authorModel?.response.items[0].date ?? 0)
//                let date = Date(timeIntervalSince1970: dateInt)
//                let dateformatter = DateFormatter()
//                dateLabel?.text = dateformatter.string(from: date)
//                print("Publication date: \(date)")
        
        
    }
            //dateLabel.text = authorModel?.response.items[0].text
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
