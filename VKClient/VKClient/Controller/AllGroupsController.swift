//
//  GroupsController.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    let groups = [
        Group(image: UIImage(named: "Books&Movies")!, name: "Books&Movies"),
        Group(image: UIImage(named: "Science")!, name: "Science"),
        Group(image: UIImage(named: "Stand up")!, name: "Stand up"),
        Group(image: UIImage(named: "ITNews")!, name: "ITNews"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var filteredGroups = [Group]()
    
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
        let groupImage = filteredGroups[indexPath.row].image
        cell.groupNameLabel.text = groupName
        cell.groupImageView.image = groupImage
        
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
