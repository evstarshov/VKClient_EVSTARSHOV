//
//  NavigationViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.08.2021.
//

import UIKit


class NewViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    @IBAction func buttonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


