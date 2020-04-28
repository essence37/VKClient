//
//  GroupsController.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class AllGroupsController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var database = GroupRepository()
    var vkApi = VKApi(parameters: [
        "access_token": "8427888c71a913e6e460d2a21d87bf002b0e277fea43a511f6b8f99d196e906cdd8544b787bd55a37e277",
        "v": "5.103",
        "order": "name",
        "fields": "photo_100"
    ], requestURL: URL(string:"https://api.vk.com/method/friends.get")!, method: .post)
    var groups = [GroupsRealm]()
    
    
//    let groups = [
//        Group(image: UIImage(named: "Books&Movies")!, name: "Books&Movies"),
//        Group(image: UIImage(named: "Science")!, name: "Science"),
//        Group(image: UIImage(named: "Stand up")!, name: "Stand up"),
//        Group(image: UIImage(named: "ITNews")!, name: "ITNews"),
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        vkApi.loadGroupsData(token: Session.instance.token) { [weak self] (groups: Result<[GroupsRealm], Error>) in
            switch groups {
            case .success(let groups):
                self?.groups = groups
                self?.database.addGroups(groups: groups)
                self?.tableView.reloadData()
            case .failure(let error): break
            }
        }
        
        self.filteredGroups = self.groups
        
    }

    var filteredGroups = [GroupsRealm]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            preconditionFailure("GroupCell cannot be dequeued")
        }
        
        let groupName = filteredGroups[indexPath.row].name
        let groupImage = filteredGroups[indexPath.row].photo
        cell.groupNameLabel.text = groupName
        // Отобразить картинку с помощью Kingfisher
        let url = URL(string: groupImage)
        cell.groupImageView.kf.setImage(with: url)
        
        return cell
    }
}

extension AllGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGroups = groups
        } else {
            filteredGroups = groups.filter{ $0.name.contains(searchText)}
        }
        tableView.reloadData()
    }
}
