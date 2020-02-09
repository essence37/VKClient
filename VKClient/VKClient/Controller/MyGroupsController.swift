//
//  MyFriendsController.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class MyGroupsController: UITableViewController {

    var myGroups = [GroupsRealm] ()
    var database = GroupRepository()
    
    var groupsResult: Results<GroupsRealm>!
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        showGroups()
    }

    func showGroups() {
        do {
            
            groupsResult = database.getAllGroups()
            
            token = groupsResult.observe { [weak self] results in
                switch results {
                case .error(let error): break
                case .initial(let groups): self?.tableView.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    print(deletions)
                    print(insertions)
                    print(modifications)
                    
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.endUpdates()
                }
            }
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupsResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            preconditionFailure("GroupCell cannot be dequeued")
        }
        
        let groupName = groupsResult[indexPath.row].name
        let groupImage = groupsResult[indexPath.row].photo
        cell.groupNameLabel.text = groupName
        // Отобразить картинку с помощью Kingfisher
        let url = URL(string: groupImage)
        cell.groupImageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let group = groupsResult[indexPath.row]
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(group.self)
                try realm.commitWrite()
//            myGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print(error)
            }
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
