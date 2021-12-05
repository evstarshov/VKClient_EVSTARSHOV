//
//  NewsTextTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 30.11.2021.
//

import UIKit

protocol NewsText {
    var newsText: String { get }
}

final class NewsTextCellModel: NewsText {
    var newsText: String
    
    init(newsText: String) {
        self.newsText = newsText
    }
}

class NewsTextTableViewCell: UITableViewCell {

    @IBOutlet weak var nextText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureText(textModel: NewsTextCellModel) {
        nextText.text? = textModel.newsText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
