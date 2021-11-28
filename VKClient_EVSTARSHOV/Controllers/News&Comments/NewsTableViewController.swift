//
//  NewsTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 08.09.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let newsService = NewsAPI()
    
    var newsFeed: NewsJSON?
    var feed: [NewsFeed] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSection()
        
        let dispatchGroup = DispatchGroup()
        
        
        DispatchQueue.global().async(group: dispatchGroup) {
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
        }
        
       
        
        
    }

    func makeSection() {
        let authorNib = UINib(nibName: "NewsAuthorTableViewCell", bundle: nil)
        self.tableView.register(authorNib, forCellReuseIdentifier: "authorCell")
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        //let textNib = UINib(nibName: "NewsTextTableViewCell", bundle: nil)
        //self.tableView.register(textNib, forCellReuseIdentifier: "NewsTextTableViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as! NewsAuthorTableViewCell
        cell.configureAuthor(authorModel: newsFeed)
        return cell
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
