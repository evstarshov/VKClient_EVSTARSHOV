//
//  GroupTableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit
import RealmSwift
import PromiseKit

class GroupTableViewController: UITableViewController {
    
    @IBOutlet var searchGroupBar: UISearchBar!
    
    private let groupsPromiseAPI = GroupsAPIPromisekit()
    private let groupsDB = GroupDB()
    private var mygroups: Results<GroupModel>?
    private var token: NotificationToken?
    
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchGroupBar.delegate = self
        
        
        if groupsDB.load().isEmpty {
            
            firstly {
                groupsPromiseAPI.getAllGroups()
            }.done { groupList in
                self.groupsDB.save(groupList)
            }.catch { error in
                print(error)
            }
            
            
            mygroups = groupsDB.load()
            
            
            token = mygroups?.observe { [weak self] changes in
                guard let self = self else { return }
                
                switch changes {
                case .initial:
                    self.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                    
                }
            }
        } else {
            self.mygroups = self.groupsDB.load()
            self.token = self.mygroups?.observe { [weak self] changes in
                guard let self = self else { return }
                
                switch changes {
                case .initial:
                    self.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let groups = mygroups else { return 0 }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath)
        let group = mygroups?[indexPath.row]
        cell.textLabel?.text = group?.name
        if let groupImage = URL(string: group?.photo100 ?? "") {
            cell.imageView?.loadImage(url: groupImage)
        }
        
        return cell
    }
}

extension GroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterGroups(with: searchText)
    }
    
    private func filterGroups(with text: String) {
        
        if !text.isEmpty {
            let data = mygroups?.filter("name CONTAINS %@", text)
            mygroups = data
            print(mygroups)
            tableView.reloadData()
        } else {
                mygroups = groupsDB.load()
            tableView.reloadData()
            }
        }
        
    }

