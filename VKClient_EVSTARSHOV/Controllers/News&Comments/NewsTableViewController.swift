//
//  NewsTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 08.09.2021.
//

import UIKit



class NewsTableViewController: UITableViewController {
    
    private let newsService = NewsAPI()
    
    private var newsFeed: NewsJSON?

    let newsRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating news feed...")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return refreshControl
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSection()

       
//        tableView.register(
//            UINib(
//                           nibName: "NewsTableViewCell",
//                            bundle: nil),
//                           forCellReuseIdentifier: "newsCell")
//        tableView.estimatedRowHeight = 600
//        tableView.rowHeight = UITableView.automaticDimension
            
            self.newsService.getNews { [weak self] news in
            self?.newsFeed = news

                
            print("GOT NEWS IN VC")
            self?.tableView.reloadData()
            }
            
        print("Number of sections: \(newsFeed?.response.items.count ?? 0)")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func refreshNews() {
        
        newsRefreshControl.endRefreshing()
        self.newsService.getNews { [weak self] news in
        self?.newsFeed = news
        print("GOT NEWS IN VC")
        self?.tableView.reloadData()
        }
    }
    

    func makeSection() {
        let authorNib = UINib(nibName: "NewsAuthorTableViewCell", bundle: nil)
        self.tableView.register(authorNib, forCellReuseIdentifier: "authorCell")
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        let textNib = UINib(nibName: "NewsTextTableViewCell", bundle: nil)
        self.tableView.register(textNib, forCellReuseIdentifier: "newsTextCell")
        let imageNib = UINib(nibName: "NewsPictureTableViewCell", bundle: nil)
        self.tableView.register(imageNib, forCellReuseIdentifier: "newsimageCell")
        let likeNib = UINib(nibName: "NewsLikesTableViewCell", bundle: nil)
        self.tableView.register(likeNib, forCellReuseIdentifier: "NewsLikesTableViewCell")
        let separatorNib = UINib(nibName: "SeparatorTableViewCell", bundle: nil)
        self.tableView.register(separatorNib, forCellReuseIdentifier: "SeparatorTableViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsFeed?.response.items.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
              let groups = newsFeed?.response.groups,
              let profiles = newsFeed?.response.profiles

        else { return UITableViewCell() }

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
            var name, string: String?
            guard let source = newsFeed?.response.items[indexPath.section].sourceID else { return UITableViewCell() }

            if source < 0 {
                groups.forEach {
                    if $0.id == abs(source) {
                        name = $0.name
                        string = $0.photo100
                    }
                }
            } else {
                profiles.forEach {
                    if $0.id == source {
                        name = $0.firstName + " " + $0.lastName
                        string = $0.photo100
                    }
                }
            }
                        print("Making author cell")
                        let avatar = newsFeed?.response.groups[indexPath.section]
                        let date = newsFeed?.response.items[indexPath.section]
                        let avatarCell = AuthorCellModel(avatar: avatar!.photo100, label: avatar!.name, date: date!.date)
                        cell.configureAuthor(model: avatarCell)
                        return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as! NewsTextTableViewCell
            print("Taping news text")
                        let text = newsFeed?.response.items[indexPath.section]
                        let newstext = NewsTextCellModel(newsText: text?.text ?? "error")
                        cell.configureText(textModel: newstext)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsimageCell", for: indexPath) as! NewsPictureTableViewCell
            guard let pictures = findURL(item: newsFeed?.response.items[indexPath.section].attachments) else { let cell = UITableViewCell()
                cell.backgroundColor = .systemGray6
                return cell }
            cell.newsPicture.loadImage(url: pictures)
            
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikesTableViewCell", for: indexPath) as! NewsLikesTableViewCell
            let likes = String(newsFeed?.response.items[indexPath.section].likes.count ?? 0)
            let comments = String(newsFeed?.response.items[indexPath.section].comments.count ?? 0)
            let reposts = String(newsFeed?.response.items[indexPath.section].reposts.count ?? 0)
            let views = String(newsFeed?.response.items[indexPath.section].views.count ?? 0)
            cell.configure(likes: likes, comments: comments, reposts: reposts, views: views)
            return cell
            
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorTableViewCell", for: indexPath) as! SeparatorTableViewCell
            return cell
        }
        else { return UITableViewCell() }
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        switch indexPath.section {
//
//        case 0:
//
//            print("Making author cell")
//            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
//            let avatar = newsFeed?.response.groups[indexPath.row]
//            let date = newsFeed?.response.items[indexPath.row]
//            let avatarCell = AuthorCellModel(avatar: avatar?.photo100 ?? "", label: avatar?.name ?? "", date: date?.date ?? 0)
//            cell.configureAuthor(model: avatarCell)
//
//            return cell
//
//        case 1:
//
//            print("Getting news text")
//            let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as! NewsTextTableViewCell
//            let text = newsFeed?.response.items[indexPath.row]
//            let newstext = NewsTextCellModel(newsText: text?.text ?? "error")
//            cell.configureText(textModel: newstext)
//            return cell
//
//        default:
//            print("Do nothing")
//            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
//            return cell
//        }
//
//
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        enum Cells {
//            case authorCell
//            case textCell
//            case likeCell
//            case imageCell
//        }
//
//        switch indexPath.section {
//
//        default:
//            print("Making author cell")
//            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
//            let avatar = newsFeed?.response.groups[indexPath.section]
//            let date = newsFeed?.response.items[indexPath.section]
//            let avatarCell = AuthorCellModel(avatar: avatar!.photo100, label: avatar!.name, date: date!.date)
//            cell.configureAuthor(model: avatarCell)
//            return cell
//
//        }
//
//
//    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextTableViewCell", for: indexPath)
//        let new = newsFeed?.response.groups[indexPath.row]
//        cell.textLabel?.text = new?.name
////        if let newsImage = URL(string: new.i) {
////            cell.imageView?.loadImage(url: newsImage) }
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true)
        }
        performSegue(
            withIdentifier: "showComments",
            sender: nil)
    }

}


extension NewsTableViewController {
    
    func findURL(item: [Attachment]?) -> URL? {
      var url = String()
      guard let item = item else {return URL(string: url)}
      for item in item {
          item.photo?.sizes.forEach {
          if $0.type == "r" {
            url = $0.url
          }
        }
      }
      return URL(string: url)
    }
    
}
