//
//  TableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit
import RealmSwift
import Alamofire

class FriendsTableViewController: UITableViewController {
    @IBOutlet var tableViewHeader: FriendsTableHeader!
    
    var friends: [FriendModel] = []
    private let friendsAPI = FriendsAPI()
    private let myfriendsDB = FriendDB()
    private var myfriends: Results<FriendModel>?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFriends()
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
        
      
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
        
        let friend = friends[indexPath.row]
        cell.configureFriend(with: friend)
        
        return cell
    }
    
    
        // Получение друзей асинхронно через Operations
    
    let friendsQueue = OperationQueue()
    private var friendsRequest: DataRequest {
        
        let baseURL = "https://api.vk.com/method"
        let token = Account.shared.token
        let userId = Account.shared.userId
        let version = "5.81"
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50, photo_100",
            "count": 10,
            "access_token": token,
            "v": version
        ]
        
        let url = baseURL + method
        
        return AF.request(url, method: .get, parameters: parameters)
    }
    
    
    func getFriends() {
        friendsQueue.qualityOfService = .userInteractive
        
        let getData = FriendsMakeAPIOperation()
        let parceData = FriendsParcingOperation()
        let displayData = FriendsDisplayOperations(controller: self)
        
        friendsQueue.addOperation(getData)
        parceData.addDependency(getData)
        friendsQueue.addOperation(parceData)
        displayData.addDependency(parceData)
        OperationQueue.main.addOperation(displayData)
    }
}
