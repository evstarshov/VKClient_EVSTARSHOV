//
//  TableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    @IBOutlet var tableViewHeader: FriendsTableHeader!
    let friendsService = FriendsAPI()
    let myfriendsDB = FriendDB()
    var myfriends: [FriendModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "friendsCell")
        
        // ----- Загрузка титульного изображения
        
        tableView.register(
            UINib(
                           nibName: "FriendsTableViewCell",
                            bundle: nil),
                           forCellReuseIdentifier: "friendsCell")
        
        tableViewHeader.imageView.image = UIImage(named: "tableHeader3")
        tableViewHeader.imageView.contentMode = .scaleAspectFill
        tableView.tableHeaderView = tableViewHeader
        //myfriendsDB.delete(friendModel)
        // Получение списка друзей из JSON
        friendsService.getFriends { [weak self] friends in
            self?.myfriends = friends
            self?.tableView.reloadData()
            self?.myfriendsDB.create(self!.myfriends)
        }
        myfriends = myfriendsDB.read()
        
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myfriends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
        let friend = myfriends[indexPath.row]
        cell.configureFriend(with: friend)
        
        return cell
    }
    
}
