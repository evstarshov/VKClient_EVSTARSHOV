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
    var mygroups: [Group] = []


        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchGroupBar.delegate = self
        
        //Получение JSON
        
        groupsService.getGroups { [weak self] groups in
            self?.mygroups = groups
            self?.tableView.reloadData()
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mygroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath)
        let group = mygroups[indexPath.row]
        cell.textLabel?.text = group.name
        
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

