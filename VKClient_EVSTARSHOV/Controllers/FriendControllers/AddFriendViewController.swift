//
//  AddFriendViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 07.09.2021.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet var addNameTextField: UITextField!
    @IBOutlet var addSecondNameTextField: UITextField!
    @IBOutlet var addGroupTextField: UITextField!
    @IBOutlet var pressOkButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addFriend(_ sender: Any) {

        if addGroupTextField.text == ""
            && addNameTextField.text == ""{
            let alertController = UIAlertController(
                title: "Ошибка",
                message: "Вы не заполнили поля",
                preferredStyle: .alert)
            let alertItem = UIAlertAction(
                title: "Ok",
                style: .cancel)
            alertController.addAction(alertItem)
            present(alertController, animated: true, completion: nil)
        }
        else {
            friendsArray.append(Friends(image: nil, name: addNameTextField.text! + " ", secondname: addSecondNameTextField.text!, groups: addGroupTextField.text!, gallery: nil))
            performSegue(withIdentifier: "friendAddedSegue", sender: pressOkButton)
        }
    }
    
}

