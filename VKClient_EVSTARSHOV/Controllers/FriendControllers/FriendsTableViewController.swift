//
//  TableViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 26.08.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    @IBOutlet var searchFriendsBar: UISearchBar!
    @IBOutlet var tableViewHeader: FriendsTableHeader!
    

    private var sectionTitles: [String] = []
    
    private var friends = [Friends]() {
        didSet {
            filteredFriends = friends
        }
    }
    
    private var filteredFriends = [Friends]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var sortedByletter = friendsArray.sorted(by: {$0.secondname < $1.secondname})
    
    private var groupedFriends: [Int:[Friends]] = [:]
    
    // --- Сортировка друзей по букве
    func sortingFriends() {
        var characters: [String.Element] = []
        sectionTitles.removeAll()
        for friend in friendsArray {
            if let secondNameCharacter = friend.secondname.first {
                if !characters.contains(secondNameCharacter) {
                    characters.append(secondNameCharacter)
                }
            }
        }
        print(characters)
        characters.sort()
        var i = 0
        var grouped: [Int:[Friends]] = [:]
        while i < characters.count {
            let character = characters[i]
            var sortedFriends: [Friends]  = []
            for friend in friendsArray {
                if let secondNameCharacter = friend.secondname.first, secondNameCharacter == character {
                    sortedFriends.append(friend)
                }
            }
            grouped[i] = sortedFriends
            sectionTitles.append(String.init(character))
            i += 1
        }
        groupedFriends = grouped
        tableView.reloadData()
    }
    // --- Сортировка друзей по букве
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFriendsBar.delegate = self
        tableView.register(
            UINib(
                           nibName: "FriendsTableViewCell",
                            bundle: nil),
                           forCellReuseIdentifier: "myfriendCell")
    
        // ----- Загрузка титульного изображения
        
        tableView.register(AllFriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        tableViewHeader.imageView.image = UIImage(named: "tableHeader3")
        tableViewHeader.imageView.contentMode = .scaleAspectFill
        tableView.tableHeaderView = tableViewHeader
        sortingFriends()
        

        
    }
    
    // ----- Загрузка титульного изображения

    // ----- Наполнение строк элементами массива
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let grouped = groupedFriends[section] {
            return grouped.count
        }
        else {
        return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
                withIdentifier: "myfriendCell",
                for: indexPath) as! FriendsTableViewCell
        guard let grouped = groupedFriends[indexPath.section] else {
            return UITableViewCell()
        }
        let groupedFriend = grouped[indexPath.row]
        cell.configure(friend: groupedFriend)
        return cell
    }
    // ----- Наполнение строк элементами массива
    
    
   // ----- Титульная строка
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as? AllFriendsSectionHeader
        else {return nil}
        sectionHeader.contentView.backgroundColor = .systemBlue
        return sectionHeader
    }
    // ------ Титульная строка
    
    
    // ----- Заголовок для секций
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // ----- Заголовок для секций
    
    // ------ Переход на экран коллекции
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true)
        }
        
        performSegue(
            withIdentifier: "showPhotoSegue",
            sender: indexPath)
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedFriend = segue.destination as? FriendsCollectionViewController else {return}
        let indexPath = sender as! IndexPath
        let friends = groupedFriends[indexPath.section]
        let friend = friends?[indexPath.row]
        let togallery = friend?.gallery
        selectedFriend.galleryItems = togallery!
        
    }
    


    
    // ------ Переход на экран коллекции
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54.0
    }
    // ------ Блок анимации
    

    
    // ------ Блок анимации
    
}

// ---- Расширения для работы поисковой строки

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends(with: searchText)
    }
    
    private func filterFriends(with text: String) {
        guard !text.isEmpty else {
            filteredFriends = friendsArray
            tableView.reloadData()
            return
        }
        
        filteredFriends = friendsArray.filter { $0.name.lowercased().contains(text.lowercased()) }
    }

}



