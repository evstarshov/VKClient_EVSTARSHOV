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
    
    var itemsArray: [NewsItem] = []
    var profilesArray: [NewsProfile] = []
    var groupsArray: [NewsGroup] = []
    
    var nextFrom = ""
    var isLoading = false
    var expandedIndexSet: IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSection()
        setupRefreshcontrol()
        tableView.prefetchDataSource = self
        
        self.newsService.getNews { [weak self] news in
            self?.newsFeed = news
            self?.itemsArray = news!.response.items
            self?.groupsArray = news!.response.groups
            self?.profilesArray = news!.response.profiles
            self?.nextFrom = news?.response.nextFrom ?? ""
            print("GOT NEWS IN VC")
            self?.tableView.reloadData()
        }
        
        print("Number of sections: \(itemsArray.count)")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
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
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let currentFeedItem = itemsArray[section]
//        var count = 1
//
//        if currentFeedItem.hasText { count += 1 }
//        if currentFeedItem.hasPhoto { count += 1 }
//        if currentFeedItem.hasLink { count += 1 }
//
//        return count
        return 5
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            switch (indexPath.row) {
            case 0:
                
                let source = itemsArray[indexPath.section].sourceID
                var name, string: String?
                if source < 0 {
                    groupsArray.forEach {
                        if $0.id == abs(source) {
                            name = $0.name
                            string = $0.photo100
                        }
                    }
                } else {
                    profilesArray.forEach {
                        if $0.id == source {
                            name = $0.firstName + " " + $0.lastName
                            string = $0.photo100
                        }
                    }
                }
                
                print("Making author cell")
                let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
                let date = itemsArray[indexPath.section]
                let avatarCell = AuthorCellModel(avatar: string ?? "no foto", label: name ?? "name error", date: date.date )
                cell.configureAuthor(model: avatarCell)
                
                return cell
                
            case 1:
                
                print("Getting news text")
                let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as! NewsTextTableViewCell
                let text = itemsArray[indexPath.section]
                let newstext = NewsTextCellModel(newsText: text.text)
                cell.configureText(textModel: newstext)
                return cell
                
            case 2:
                print("Getting image")
                let cell = tableView.dequeueReusableCell(withIdentifier: "newsimageCell", for: indexPath) as! NewsPictureTableViewCell
                guard let pictures = findURL(item: itemsArray[indexPath.section].attachments) else { let cell = UITableViewCell()
                    cell.backgroundColor = .systemGray6
                    return cell }
                cell.newsPicture.loadImage(url: pictures)
                
                return cell
            case 3:
                print("Getting likes")
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikesTableViewCell", for: indexPath) as! NewsLikesTableViewCell
                let likes = String(itemsArray[indexPath.section].likes.count)
                let comments = String(itemsArray[indexPath.section].comments.count)
                let reposts = String(itemsArray[indexPath.section].reposts.count)
                let views = String(itemsArray[indexPath.section].views?.count ?? 0)
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true)
        }
        performSegue(
            withIdentifier: "showComments",
            sender: nil)
    }
    
    // ----- Расчет размера фото
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        func currentPhotoHeight(_ item: NewsItem) -> CGFloat {
            guard let height = item.attachments?[0].photo?.photoAvailable?.height else { return UITableView.automaticDimension }
            guard let width = item.attachments?[0].photo?.photoAvailable?.width else { return UITableView.automaticDimension }
            
            let tableWidth = tableView.bounds.width
            
            let aspectRatio = CGFloat(height) / CGFloat(width)
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        }
        
        let currentItem = itemsArray[indexPath.section]
        
        switch indexPath.row {
        case 2:
            print("Returning image aspect ratio")
            return currentPhotoHeight(currentItem)
        default:
            return UITableView.automaticDimension
        }
        

    }
    

    // ----- Refresh Control block
    
    let newsRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating news feed...")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return refreshControl
    }()
    
    fileprivate func setupRefreshcontrol() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing news...")
        refreshControl?.tintColor = .systemBlue
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
    }
    
    @objc func refreshNews() {
        self.refreshControl?.beginRefreshing()
        
        let mostFreshNewsDate = self.itemsArray.first?.date ?? Int(Date().timeIntervalSince1970)
        print("refreshing from \(mostFreshNewsDate)")
        
        newsService.getNews(startTime: mostFreshNewsDate + 1) { [weak self] feed in
            guard let self = self else {return}
            print("begin upload")
            self.refreshControl?.endRefreshing()
            
            
            guard let items = feed?.response.items else { return }
            guard let profiles = feed?.response.profiles else { return }
            guard let groups = feed?.response.groups else { return }
            guard items.count > 0 else { return }
            print("new items: \(items.count)")
            
            self.itemsArray = items + self.itemsArray
            self.profilesArray = profiles + self.profilesArray
            self.groupsArray = groups + self.groupsArray
            
            let indexSet = IndexSet(integersIn: 0..<items.count)
            self.tableView.insertSections(indexSet, with: .automatic)
            print("setted refresh func")
        }
    }
    
    
    
    
}


extension NewsTableViewController {
    
    func findURL(item: [Attachment]?) -> URL? {
        var url = String()
        guard let item = item else {return URL(string: url)}
        for item in item {
            item.photo?.sizes?.forEach {
                if $0.type == "r" {
                    url = $0.url
                }
            }
        }
        return URL(string: url)
    }
    
}

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        print("Prefetching news")
        
        
        if maxSection > itemsArray.count - 3, !isLoading {
            isLoading = true
            newsService.getNews(startFrom: nextFrom) { [weak self] news in
                guard let self = self else { return }
                
                guard let newItems = news?.response.items else { return }
                guard let newProfiles = news?.response.profiles else { return }
                guard let newGroups = news?.response.groups else { return }
                
                let indexSet = IndexSet(integersIn: self.itemsArray.count..<self.itemsArray.count + newItems.count)
                
                self.itemsArray.append(contentsOf: newItems)
                self.profilesArray.append(contentsOf: newProfiles)
                self.groupsArray.append(contentsOf: newGroups)
                print("Inside prefetch closure")
                self.nextFrom = news?.response.nextFrom ?? ""
                self.tableView.insertSections(indexSet, with: .automatic)
                self.isLoading = false
            }
        }
    }
}
