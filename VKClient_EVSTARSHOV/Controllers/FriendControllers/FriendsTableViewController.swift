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
    
    private let friendsAPI = FriendsAPI()
    private let myfriendsDB = FriendDB()
    private var myfriends: Results<FriendModel>?
    private var token: NotificationToken?
    
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
        // Получение списка друзей из JSON
        
        friendsAPI.getFriends { [ weak self ] friends in
            
            guard let self = self else { return }
            
            self.myfriendsDB.save(friends)
            
            self.myfriends = self.myfriendsDB.load()
            self.token = self.myfriends?.observe { [weak self] changes in
                guard let self = self else { return }
                
                switch changes {
                case .initial:
                    self.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
            
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let friends = myfriends else { return 0 }
        
        return friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
        
        let friend = myfriends?[indexPath.row]
        cell.configureFriend(with: friend!)
        
        return cell
    }
    
}
