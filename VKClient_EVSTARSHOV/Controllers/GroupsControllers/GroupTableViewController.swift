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
    var groups = [Groups]() {
    didSet {
        filteredGroups = groups
        }
    }
    
    private var filteredGroups = [Groups]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroupSegue",
        let vc = segue.source as? AllGroupsTableViewController,
            let index = vc.tableView.indexPathForSelectedRow?.row
        else { return }
        let group = vc.groups[index]
        if !groups.contains(group) {
            groups.append(group)
        }
    }
        

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchGroupBar.delegate = self
        
        //Получение JSON
        
        groupsService.getGroups { groups in
            print("Got groups in VC")
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(
                withIdentifier: "groupsCell",
                for: indexPath)
        cell.textLabel?.text = filteredGroups[indexPath.row].groupname
        cell.imageView?.image = filteredGroups[indexPath.row].groupimage
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = ""
        return cell
    }
}

extension GroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterGroups(with: searchText)
    }
    
    private func filterGroups(with text: String) {
        guard  !text.isEmpty else {
            filteredGroups = groups
            tableView.reloadData()
            return
        }
        filteredGroups = groups.filter {
            $0.groupname.lowercased().contains(text.lowercased()) }
        }
    }

