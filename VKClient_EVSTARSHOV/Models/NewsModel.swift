//
//  NewsModel.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 08.09.2021.
//

import UIKit


var newsArray = [NewsModel(ntitle: "Реалистик!", ntext: "Топ залайканных постов за неделю. 💟 Какой арт лучше?", nimage: UIImage(named: "newsImage"), commenttext: "Liked!", nfriend: friendsArray[1])]

var commentsArray = [Comments(ncomment: "Вот это задница"), Comments(ncomment: "Лайк")]

class NewsModel {

    
    let newsTitle: String?
    let newsText: String?
    let newsImage: UIImage?
    let commentText: String?
    var friendPosted: Friends
    
    init(ntitle: String, ntext: String, nimage: UIImage?, commenttext: String, nfriend: Friends) {
        self.newsTitle = ntitle
        self.newsText = ntext
        self.newsImage = nimage
        self.commentText = commenttext
        self.friendPosted = nfriend
    }
}


func loadNewsData() {
    _ = newsArray
}

class Comments {
    let commentarium: String?
    init(ncomment: String){
        self.commentarium = ncomment
    }
}
