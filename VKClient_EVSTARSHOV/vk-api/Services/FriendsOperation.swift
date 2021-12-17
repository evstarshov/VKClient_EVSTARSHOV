//
//  FriendsOperation.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 05.12.2021.
//

import Foundation
import Alamofire
import RealmSwift

final class FriendsMakeAPIOperation: AsyncOperation {
    
   private(set) var data: Data?
    
    override func cancel() {
      request.cancel()
      super.cancel()
    }
    
        var request: DataRequest {
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
        
    override func main() {
        request.responseData { [weak self]
            response in
            self?.data = response.data
            self?.state = .finished
        }
    }
        
    
}

final class FriendsParcingOperation: AsyncOperation {
    
   
    private(set) var friendsList: [FriendModel]?
    
    override func main() {
        guard let operation = self.dependencies.first as? FriendsMakeAPIOperation,
              let data = operation.data,
              let users = try? JSONDecoder().decode(FriendsJSON.self, from: data).response.items else { return }
        self.friendsList = users
        self.state = .finished
    }
}

final class FriendsDisplayOperations: AsyncOperation {
    
    var friendsViewController: FriendsTableViewController
    
    override func main() {
        guard let parsedFriendsListData = dependencies.first as? FriendsParcingOperation,
              let friendsList = parsedFriendsListData.friendsList else { return }
        self.friendsViewController.friends = friendsList
        friendsViewController.tableView.reloadData()
        self.state = .finished
        }
    
    init(controller: FriendsTableViewController) {
        
        self.friendsViewController = controller
    
    }
}


class AsyncOperation: Operation {
  
  enum State: String {
    case ready, executing, finished
    
    fileprivate var keyPath: String {
      return "is" + self.rawValue.capitalized
    }
  }
  
  var state: State = State.ready {
    willSet {
      self.willChangeValue(forKey: self.state.keyPath)
      self.willChangeValue(forKey: newValue.keyPath)
    }
    
    didSet {
      self.didChangeValue(forKey: self.state.keyPath)
      self.didChangeValue(forKey: oldValue.keyPath)
    }
  }
  
  let databaseService = FriendDB()
  
  override var isAsynchronous: Bool {
    return true
  }
  
  override var isReady: Bool {
    return super.isReady && self.state == .ready
  }
  
  override var isExecuting: Bool {
    return self.state == .executing
  }
  
  override var isFinished: Bool {
    return self.state == .finished
  }
  
  override func start() {
    if self.isCancelled {
      self.state = .finished
    } else {
      self.main()
      self.state = .executing
    }
  }
  
  override func cancel() {
    super.cancel()
    self.state = .finished
  }
  
  func finished() {
    self.state = .finished
  }
}

