//
//  CommentNewsTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 09.09.2021.
//

import UIKit

class CommentNewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return commentsArray.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(
                withIdentifier: "commentСell",
                for: indexPath)
        cell.textLabel?.text = commentsArray[indexPath.row].commentarium
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = ""
        return cell
    }
}


