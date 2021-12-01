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
        
    }
    

    func makeSection() {
        let authorNib = UINib(nibName: "NewsAuthorTableViewCell", bundle: nil)
        self.tableView.register(authorNib, forCellReuseIdentifier: "authorCell")
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        let textNib = UINib(nibName: "NewsTextTableViewCell", bundle: nil)
        self.tableView.register(textNib, forCellReuseIdentifier: "newsTextCell")
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = newsFeed else { return 0 }
        return sections.response.items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = newsFeed else { return 0 }
        return sections.response.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            print("Making author cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
            let feed = newsFeed?.response.groups[indexPath.row]
            let date = newsFeed?.response.items[indexPath.row]
            let avatar = AuthorCellModel(avatar: feed!.photo100, label: feed!.name, date: date!.date)
            cell.configureAuthor(model: avatar)
        
            return cell
            
        case 1:
            
            print("Getting news text")
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as! NewsTextTableViewCell
            let text = newsFeed?.response.items[indexPath.row]
            let newstext = NewsTextCellModel(newsText: text?.text ?? "error")
            cell.configureText(textModel: newstext)
            return cell
        
        default:
            print("Do nothing")
            let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
            return cell
        }
        
        
    }
    

    
    
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
