//
//  NewsTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 08.09.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsTitleCell: UILabel!
    @IBOutlet var newsTextCell: UILabel!
    @IBOutlet var newsImageCell: UIImageView!
    @IBOutlet var avatarImageCell: AvatarImage!
    @IBOutlet var friendLabelCell: UILabel!
    @IBOutlet var commentsTable: UITableViewCell!
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var likesLabelCell: UILabel!
    var likes = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
        if likeBtn.isSelected == false {
        print("Liked")

            likeBtn.isSelected = true
        likes += 1
            likesLabelCell.text = String(likes)
            likeBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                UIView.animate(withDuration: 1.6,
                               delay: 0,
                               usingSpringWithDamping: 0.4,
                               initialSpringVelocity: 0.2,
                               options: .curveEaseOut,
                               animations: {
                                   self.likeBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
                               },
                               completion: nil)
            likeBtn.setImage(UIImage(named: "heartfill"), for: .selected)
        } else {
            print("Disliked")
            likeBtn.isSelected = false
            likes -= 1
            likesLabelCell.text = String(likes)
        }
        
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {

    }
    
    func configureNews(model: NewsItem) {
        
        newsTextCell.text = model.text
        
        
        //        if let newsImage = URL(string: model.newsSizes[1].url) {
        //            newsImageCell.loadImage(url: newsImage) }
        
//        newsTitleCell.text = model.newsGroupTitle[1].name
//        newsTextCell.text = model.newsText[1].text
//
//        if let newsImage = URL(string: model.newsSizes[1].url) {
//            newsImageCell.loadImage(url: newsImage) }
//
//        if let newsAvatar = URL(string: model.newsGroupTitle[1].photo200) {
//            avatarImageCell.loadImage(url: newsAvatar) }
//
//        friendLabelCell.text = model.newsGroupTitle[1].screenName
    }
    
}
