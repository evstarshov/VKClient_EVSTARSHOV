//
//  TableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    @IBOutlet var tableViewHeader: FriendsTableHeader!
    let friendsService = FriendsAPI()
    var myfriends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // ----- Загрузка титульного изображения
        
        tableView.register(AllFriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        tableViewHeader.imageView.image = UIImage(named: "tableHeader3")
        tableViewHeader.imageView.contentMode = .scaleAspectFill
        tableView.tableHeaderView = tableViewHeader
        
        // Получение списка друзей из JSON
      
                friendsService.getFriends { [weak self] friends in
                    self?.myfriends = friends
                    self?.tableView.reloadData()
                }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myfriends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = myfriends[indexPath.row]
        cell.textLabel?.text = friend.fullName
        
        return cell
    }
    
}
