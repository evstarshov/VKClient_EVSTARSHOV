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
            likeBtn.setImage(UIImage(named: "heartfill"), for: .selected)
        } else {
            print("Disliked")
            likeBtn.isSelected = false
            likes -= 1
            likesLabelCell.text = String(likes)
        }
        
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        if let comment = commentTextField.text, comment != "" {
            commentsArray.append(Comments(ncomment: commentTextField.text!))
            commentTextField.text = ""
        }
    }
    
    func configureNews(model: NewsModel) {
        newsTitleCell.text = model.newsTitle
        newsTextCell.text = model.newsText
        newsImageCell.image = model.newsImage
        avatarImageCell.image = model.friendPosted.image
        friendLabelCell.text = model.friendPosted.name
    }
    
}

//class CommentTableViewCell: UITableViewCell {
//    let comments: Comments
//    init(commentcell: Comments) {
//        self.comments = commentcell
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//     let cell = tableView.dequeueReusableCell(
//                withIdentifier: "commentCell",
//                for: indexPath)
//        cell.textLabel?.text = commentsArray[indexPath.row].commentarium
//        return cell
//    }
//
//}
