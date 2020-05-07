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
import Alamofire

class AllGroupsController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var database = GroupRepository()
    var vkApi = VKApi()
    var groups = [GroupItem]()
    
    
//    let groups = [
//        Group(image: UIImage(named: "Books&Movies")!, name: "Books&Movies"),
//        Group(image: UIImage(named: "Science")!, name: "Science"),
//        Group(image: UIImage(named: "Stand up")!, name: "Stand up"),
//        Group(image: UIImage(named: "ITNews")!, name: "ITNews"),
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let opq = OperationQueue()
        let parameters: Parameters = [
            "access_token": Session.instance.token,
            "v": "5.103",
            "extended": "1",
            "fields": "photo_100, name"
        ]
        let request = AF.request("https://api.vk.com/method/groups.get", method: .get, parameters: parameters)
        let getDataOperation = GetDataOperation(request: request)
        opq.addOperation(getDataOperation)
        
        let parseData = ParseData()
        parseData.addDependency(getDataOperation)
        opq.addOperation(parseData)
        
        let reloadTableController = ReloadTableController(controller: self)
        reloadTableController.addDependency(parseData)
        OperationQueue.main.addOperation(reloadTableController)
        
        
        

//        vkApi.loadGroupsData(token: Session.instance.token) { [weak self] (groups: Result<[GroupsRealm], Error>) in
//            switch groups {
//            case .success(let groups):
//                self?.groups = groups
//                self?.database.addGroups(groups: groups)
//                self?.tableView.reloadData()
//            case .failure(let error): break
//            }
//        }
        
        self.filteredGroups = self.groups
        
    }

    var filteredGroups = [GroupItem]()
    
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
