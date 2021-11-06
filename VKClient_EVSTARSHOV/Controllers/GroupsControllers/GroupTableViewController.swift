//
//  GroupTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {

    @IBOutlet var searchGroupBar: UISearchBar!
    let groupsService = GroupsAPI()
    let groupsDB = GroupDB()
    var mygroups: [GroupModel] = []


        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchGroupBar.delegate = self
        
        //Получение JSON
        var numberOfgroups = 0
        
        mygroups = groupsDB.read()
        numberOfgroups = groupsDB.read().count
        tableView.reloadData()
        
        if numberOfgroups == 0 {
        groupsService.getGroups { [weak self] groups in
            self?.mygroups = groups
            self?.tableView.reloadData()
            self?.groupsDB.create(self!.mygroups)
            numberOfgroups = self!.groupsDB.read().count
        }
        }
            else if numberOfgroups == groupsDB.read().count{
                print("no groups to load")
            }
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mygroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath)
        let group = mygroups[indexPath.row]
        cell.textLabel?.text = group.name
        if let groupImage = URL(string: group.photo100) {
            cell.imageView?.loadImage(url: groupImage)
        }
        
        return cell
    }
    }


//extension GroupTableViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterGroups(with: searchText)
//    }
//    
//    private func filterGroups(with text: String) {
//        guard  !text.isEmpty else {
//            filteredGroups = groups
//            tableView.reloadData()
//            return
//        }
//        filteredGroups = groups.filter {
//            $0.groupname.lowercased().contains(text.lowercased()) }
//        }
//    }

