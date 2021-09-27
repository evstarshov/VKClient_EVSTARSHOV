//
//  GroupTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {

    @IBOutlet var searchGroupBar: UISearchBar!
    
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
        sort(groupsArray)
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
extension GroupTableViewController {
    private func sort(_ groupsArray: [Groups]) -> (characters: [Character], sortedGroups: [Character: [Groups]]) {
        var letters = [Character]()
        var sortedGroups = [Character: [Groups]]()
        
        groupsArray.forEach { group in
            guard let character = group.groupname.first else { return }
            if var thisCharGroups = sortedGroups[character] {
                thisCharGroups.append(group)
                sortedGroups[character] = thisCharGroups
            } else {
                sortedGroups[character] = [group]
                letters.append(character)
            }
        }
        letters.sort()
        print(sortedGroups)
        return (letters, sortedGroups)
        
    }
}
