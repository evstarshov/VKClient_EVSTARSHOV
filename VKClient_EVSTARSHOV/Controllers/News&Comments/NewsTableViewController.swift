//
//  NewsTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 08.09.2021.
//

import UIKit



class NewsTableViewController: UITableViewController {
    
    @IBOutlet weak var refreshBTN: UIBarButtonItem!
    
    private let newsService = NewsAPI()
    private var newsFeed: NewsJSON?

    let newsRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating news feed...")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSection()

            self.newsService.getNews { [weak self] news in
            self?.newsFeed = news

                
            print("GOT NEWS IN VC")
            self?.tableView.reloadData()
            }
            
        print("Number of sections: \(newsFeed?.response.items.count ?? 0)")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    @IBAction func refreshNewsBtnpressed(_ sender: Any) {
        if refreshBTN.isEnabled == true {
        print("Refresh News button pressed")
        self.newsService.getNews { [weak self] news in
        self?.newsFeed = news
        print("GOT NEWS IN VC")
        self?.tableView.reloadData()
            }
        }
    }
    
    @objc func refreshNews() {
        print("Refreshing news")
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
        
        guard let profiles = newsFeed?.response.profiles,
              let groups = newsFeed?.response.groups,
              let items = newsFeed?.response.items else { return UITableViewCell() }
        
        
        let source = items[indexPath.section].sourceID
        var name, string: String?
        if source < 0 {
            groups.forEach {
                if $0.id == abs(source) {
                    name = $0.name
                    string = $0.photo100
                } else {
                    profiles.forEach {
                        if $0.id == source {
                            name = $0.firstName + " " + $0.lastName
                            string = $0.photo100
                        }
                }
        }
            }
        }
        
        switch (indexPath.section) {
            
            default:
            
            switch (indexPath.row) {
            case 0:

            print("Making author cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
            let date = items[indexPath.section]
                let avatarCell = AuthorCellModel(avatar: string ?? "no foto", label: name ?? "name error", date: date.date )
            cell.configureAuthor(model: avatarCell)

            return cell

        case 1:

            print("Getting news text")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as! NewsTextTableViewCell
            let text = items[indexPath.section]
            let newstext = NewsTextCellModel(newsText: text.text)
            cell.configureText(textModel: newstext)
            return cell
                    
                case 2:
                    print("Getting image")
                                let cell = tableView.dequeueReusableCell(withIdentifier: "newsimageCell", for: indexPath) as! NewsPictureTableViewCell
                                guard let pictures = findURL(item: items[indexPath.section].attachments) else { let cell = UITableViewCell()
                                    cell.backgroundColor = .systemGray6
                                    return cell }
                                cell.newsPicture.loadImage(url: pictures)
                    
                                return cell
                case 3:
                print("Getting likes")
                                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikesTableViewCell", for: indexPath) as! NewsLikesTableViewCell
                                let likes = String(items[indexPath.section].likes.count)
                                let comments = String(items[indexPath.section].comments.count)
                                let reposts = String(items[indexPath.section].reposts.count)
                                let views = String(items[indexPath.section].views.count)
                                cell.configure(likes: likes, comments: comments, reposts: reposts, views: views)
                                return cell
                case 4:
                print("Putting separator")
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorTableViewCell", for: indexPath) as! SeparatorTableViewCell
                cell.backgroundColor = .systemGray
                return cell

        default:
            print("Do nothing in row")
                    return UITableViewCell()
            }
        }
    }
    
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

