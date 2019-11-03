//
//  AllFriendsController.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    let friends = [
// было Friend(image: UIImage(named: "Rachel")!, name: "Rachel Green"),
        User(image: (UIImage(named: "Rachel")!), name: "Rachel Green"),
        User(image: (UIImage(named: "Monica")!), name: "Monica Geller-Bing"),
        User(image: (UIImage(named: "Phoebe")!), name: "Phoebe Buffay"),
        User(image: (UIImage(named: "Joey")!), name: "Joey Tribbiani"),
        User(image: (UIImage(named: "Chandler")!), name: "Chandler Bing"),
        User(image: (UIImage(named: "Ross")!), name: "Ross Geller"),
        
//        ниже: так будет выглядеть с галереей-массивом фотографий, фото f1 f2 загружены в Assets
//        User(image: (UIImage(named: "Ross")!), name: "Ross Geller", photos: [(UIImage(named: "f1")!),(UIImage(named: "f2")!)])
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell else {
            preconditionFailure("FriendsCell cannot be dequeued")
        }
        /*
        let friendName = friends[indexPath.row].name
        let friendImage = friends[indexPath.row].image
        cell.friendNameLabel.text = friendName
        cell.friendImageView.image = friendImage
        */
        
        cell.friendNameLabel.text = friends[indexPath.row].name
        cell.friendImageView?.image = friends[indexPath.row].image
        
        return cell
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show friend image",
            let destinationVC = segue.destination as? MyFriendProfileController,
            let indexPath = tableView.indexPathForSelectedRow {
            let friendName = friends[indexPath.row].name
            destinationVC.title = friendName
        }
    }
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show friend image" {
            guard let destinationController = segue.destination as? MyFriendProfileController else { return }
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            if friends.count > index {
                let friend = friends[index] 
                destinationController.navigationItem.title = friend.name //
                destinationController.friendImage = friend.image
            }
        }
    }
}
