//
//  NewsModel.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 08.09.2021.
//

import UIKit
import Foundation

enum NewsFeedEnum {
    case authorName
    case authorAvatar
    case publicationDate
    case publicationText
    case publicationPicture
    case newsLikes
}

final class NewsFeed: Codable {
    
    var vkItems: [NewsItem]
    var vkProfile: [NewsProfile]
    var vkGroup: [NewsGroup]
    let response: [NewsResponse]
    
    init(vkItems: [NewsItem], vkProfile: [NewsProfile], vkGroup: [NewsGroup], response: [NewsResponse]) {
        self.vkItems = vkItems
        self.vkProfile = vkProfile
        self.vkGroup = vkGroup
        self.response = response
    }
}


// MARK: - Welcome
class NewsJSON: Codable {
    let response: NewsResponse

    init(response: NewsResponse) {
        self.response = response
    }
}

// MARK: - Response
class NewsResponse: Codable {
    let items: [NewsItem]
    let groups: [NewsGroup]
    let profiles: [NewsProfile]
//    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
//        case nextFrom = "next_from"
    }

    init(items: [NewsItem], groups: [NewsGroup], profiles: [NewsProfile]
         //nextFrom: String
    ) {
        self.items = items
        self.groups = groups
        self.profiles = profiles
        //self.nextFrom = nextFrom
    }
}

// MARK: - Group
class NewsGroup: Codable {
    let id: Int
    let photo100, photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }

    init(id: Int, photo100: String, photo50: String, photo200: String, type: String, screenName: String, name: String, isClosed: Int) {
        self.id = id
        self.photo100 = photo100
        self.photo50 = photo50
        self.photo200 = photo200
        self.type = type
        self.screenName = screenName
        self.name = name
        self.isClosed = isClosed
    }
}

// MARK: - Item
class NewsItem: Codable {
    let comments: Comments
    let canSetCategory: Bool
    let likes: NewsLikes
    let reposts: NewsReposts
    let type, postType: String
    let date, sourceID: Int
    let text: String
    let canDoubtCategory: Bool
    let attachments: [Attachment]
    let markedAsAds, postID: Int
    let postSource: PostSource
    let views: Views

    enum CodingKeys: String, CodingKey {
        case comments
        case canSetCategory = "can_set_category"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case postSource = "post_source"
        case views
    }

    init(comments: Comments, canSetCategory: Bool, likes: NewsLikes, reposts: NewsReposts, type: String, postType: String, date: Int, sourceID: Int, text: String, canDoubtCategory: Bool, attachments: [Attachment], markedAsAds: Int, postID: Int, postSource: PostSource, views: Views) {
        self.comments = comments
        self.canSetCategory = canSetCategory
        self.likes = likes
        self.reposts = reposts
        self.type = type
        self.postType = postType
        self.date = date
        self.sourceID = sourceID
        self.text = text
        self.canDoubtCategory = canDoubtCategory
        self.attachments = attachments
        self.markedAsAds = markedAsAds
        self.postID = postID
        self.postSource = postSource
        self.views = views
    }
}

// MARK: - Attachment
class Attachment: Codable {
    let type: String
    let link: Link

    init(type: String, link: Link) {
        self.type = type
        self.link = link
    }
}

// MARK: - Link
class Link: Codable {
    let title, caption: String
    let url: String
    let linkDescription: String
    let photo: NewsPhoto

    enum CodingKeys: String, CodingKey {
        case title, caption, url
        case linkDescription = "description"
        case photo
    }

    init(title: String, caption: String, url: String, linkDescription: String, photo: NewsPhoto) {
        self.title = title
        self.caption = caption
        self.url = url
        self.linkDescription = linkDescription
        self.photo = photo
    }
}

// MARK: - Photo
class NewsPhoto: Codable {
    let albumID, id, date: Int
    let text: String
    let userID: Int
    let newsSizes: [NewsSize]
    let hasTags: Bool
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case newsSizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }

    init(albumID: Int, id: Int, date: Int, text: String, userID: Int, newsSizes: [NewsSize], hasTags: Bool, ownerID: Int) {
        self.albumID = albumID
        self.id = id
        self.date = date
        self.text = text
        self.userID = userID
        self.newsSizes = newsSizes
        self.hasTags = hasTags
        self.ownerID = ownerID
    }
}

// MARK: - Size
class NewsSize: Codable {
    let width, height: Int
    let url: String
    let type: String

    init(width: Int, height: Int, url: String, type: String) {
        self.width = width
        self.height = height
        self.url = url
        self.type = type
    }
}

// MARK: - Comments
class Comments: Codable {
    let count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }

    init(count: Int, canPost: Int) {
        self.count = count
        self.canPost = canPost
    }
}

// MARK: - Likes
class NewsLikes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }

    init(canLike: Int, canPublish: Int, count: Int, userLikes: Int) {
        self.canLike = canLike
        self.canPublish = canPublish
        self.count = count
        self.userLikes = userLikes
    }
}

// MARK: - PostSource
class PostSource: Codable {
    let type: String

    init(type: String) {
        self.type = type
    }
}

// MARK: - Reposts
class NewsReposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }

    init(count: Int, userReposted: Int) {
        self.count = count
        self.userReposted = userReposted
    }
}

// MARK: - Views
class Views: Codable {
    let count: Int

    init(count: Int) {
        self.count = count
    }
}

// MARK: - Profile
class NewsProfile: Codable {
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let screenName, firstName: String

    enum CodingKeys: String, CodingKey {
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }

    init(online: Int, id: Int, photo100: String, lastName: String, photo50: String, onlineInfo: OnlineInfo, sex: Int, screenName: String, firstName: String) {
        self.online = online
        self.id = id
        self.photo100 = photo100
        self.lastName = lastName
        self.photo50 = photo50
        self.onlineInfo = onlineInfo
        self.sex = sex
        self.screenName = screenName
        self.firstName = firstName
    }
}

// MARK: - OnlineInfo
class OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
    }

    init(visible: Bool, isMobile: Bool, isOnline: Bool) {
        self.visible = visible
        self.isMobile = isMobile
        self.isOnline = isOnline
    }
}


// ------------- ТЕСТОВЫЕ ДАННЫЕ

var newsArray = [NewsModel(ntitle: "Реалистик!", ntext: "Топ залайканных постов за неделю. 💟 Какой арт лучше?", nimage: UIImage(named: "newsImage"), commenttext: "Liked!", nfriend: friendsArray[1])]

var commentsArray = [OldComments(ncomment: "Вот это задница"), OldComments(ncomment: "Лайк")]

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

class OldComments {
    let commentarium: String?
    init(ncomment: String){
        self.commentarium = ncomment
    }
}
