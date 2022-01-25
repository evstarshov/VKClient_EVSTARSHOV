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
    
    var friends: [FriendsAdapterStruct] = []
    private let friendsAPI = FriendsAdapter()
    private let myfriendsDB = FriendDB()
    private var token: NotificationToken?
    private let viewModelFactory = FriendViewModelFactory()
    private var viewModels: [FriendViewModel] = []
    private let proxy = FriendsServiceProxy(friendsService: FriendsAdapter())
    
    override func viewDidLoad() {
        

        
        super.viewDidLoad()
        tableView.reloadData()
        print("Realm DB is here \(Realm.Configuration.defaultConfiguration.fileURL!)")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "friendsCell")
        proxy.getFriends { [weak self] friend in

            self?.friends = friend
            self?.viewModels = self?.viewModelFactory.constructViewModels(from: friend) ?? [FriendViewModel(friendName: "name error", friendAvatar: "avatar error")]
            self?.tableView.reloadData()
        }
        friendsAPI.getFriends { [weak self] friend in
            
            self?.friends = friend
            self?.viewModels = self?.viewModelFactory.constructViewModels(from: friend) ?? [FriendViewModel(friendName: "name error", friendAvatar: "avatar error")]
            self?.tableView.reloadData()
        }

        
        // ----- Загрузка титульного изображения
        
        tableView.register(
            UINib(
                nibName: "FriendsTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "friendsCell")
        
        tableViewHeader.imageView.image = UIImage(named: "tableHeader3")
        tableViewHeader.imageView.contentMode = .scaleAspectFill
        tableView.tableHeaderView = tableViewHeader

        
      
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return viewModels.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
        
        cell.configureFriend(with: viewModels[indexPath.row])
        
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
        let realmData = FriendsRealmOperation()
        let displayData = FriendsDisplayOperations(controller: self)
        
        friendsQueue.addOperation(getData)
        parceData.addDependency(getData)
        friendsQueue.addOperation(parceData)
        realmData.addDependency(parceData)
        friendsQueue.addOperation(realmData)
        displayData.addDependency(realmData)
        

        
        OperationQueue.main.addOperation(displayData)
    }
}
