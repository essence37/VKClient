//
//  MyFriendsController.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {

    var vkApi = VKApi()
    
    var myGroups = [Group] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        vkApi.loadGroupsData(token: Session.instance.token) { [weak self] (groups: Result<[Group], Error>) in
            switch groups {
            case .success(let myGroups):
                self?.myGroups = myGroups
                self?.tableView.reloadData()
            case .failure(let error): break
            }
        }
//        let session = Session.instance
//        session.token = "1"
//        session.userId = 1
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            preconditionFailure("GroupCell cannot be dequeued")
        }
        
        let groupName = myGroups[indexPath.row].name
        let groupImage = myGroups[indexPath.row].image
        cell.groupNameLabel.text = groupName
        cell.groupImageView.image = groupImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AllGroupsController,
            let indexPath = sourceVC.tableView.indexPathForSelectedRow {
            let group = sourceVC.groups[indexPath.row]
            if !myGroups.contains(where: { $0.name == group.name}) {
                myGroups.append(group)
                tableView.reloadData()
            }
        }
    }


}
