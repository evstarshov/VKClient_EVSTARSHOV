//
//  AddFriendViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 07.09.2021.
//

import UIKit
import Firebase

class AddFriendViewController: UIViewController {

    let authService = Auth.auth()
    
    let ref = Database.database().reference(withPath: "friends") //ссылка на контейнер в Firebase Database

    var friends: [FriendsFirebase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ref.observe(.value, with: { snapshot in
//
//            var friends: [FriendsFirebase] = []
//
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                   let friend = FriendsFirebase(snapshot: snapshot) {
//                    friends.append(friend)
//                }
//            }
//            self.friends = friends
//            let _ = self.friends.map { print($0.id, $) }
//
//
//        })

    }
    

    
    @IBAction func addFriend(_ sender: Any) {
        
//        let alert = UIAlertController(title: "Добавить друга", message: nil, preferredStyle: .alert)
//        
//        let cancel = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
//        
//        let save = UIAlertAction(title: "Сохранить друга", style: .default) { _ in
//            
//            guard let textField = alert.textFields?.first,
//                  let friendName = textField.text,
//            let lastName = textField.text else { return }
//            
//            
//            let friend = FriendsFirebase(firstName: friendName, lastName: lastName)
//            
//            
//            let cityContainerRef = self.ref.child(friendName)
//            
//            
//            cityContainerRef.setValue(friend.toAnyObject())
//        }
//        
//        alert.addTextField()
//        alert.addAction(cancel)
//        alert.addAction(save)
//        
//        present(alert, animated: true, completion: nil)
    }
    
}

