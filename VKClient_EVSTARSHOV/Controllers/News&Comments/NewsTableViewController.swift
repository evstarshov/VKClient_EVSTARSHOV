//
//  NewsTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 08.09.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let newsService = NewsAPI()
    var news: [NewsJSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(
                           nibName: "NewsTableViewCell",
                            bundle: nil),
                           forCellReuseIdentifier: "newsCell")
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension

        newsService.getNews { [weak self] news in
            
            guard let self = self else { return }
            
            self.news = news
            self.tableView.reloadData()
            
        }
        
        
    }



    override func numberOfSections(in tableView: UITableView) -> Int {

        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        let new = newsArray[indexPath.row]
        cell.configureNews(model: new)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true)
        }
        performSegue(
            withIdentifier: "showComments",
            sender: nil)
    }

}
