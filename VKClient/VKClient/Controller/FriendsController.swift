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
        Friend(image: UIImage(named: "Rachel")!, name: "Rachel Green"),
        Friend(image: UIImage(named: "Monica")!, name: "Monica Geller-Bing"),
        Friend(image: UIImage(named: "Phoebe")!, name: "Phoebe Buffay"),
        Friend(image: UIImage(named: "Joey")!, name: "Joey Tribbiani"),
        Friend(image: UIImage(named: "Chandler")!, name: "Chandler Bing"),
        Friend(image: UIImage(named: "Ross")!, name: "Ross Geller")
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
        
        let friendName = friends[indexPath.row].name
        let friendImage = friends[indexPath.row].image
        cell.friendNameLabel.text = friendName
        cell.friendImageView.image = friendImage
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show friend image",
            let destinationVC = segue.destination as? MyFriendProfileController,
            let indexPath = tableView.indexPathForSelectedRow {
            let friendName = friends[indexPath.row].name
            destinationVC.title = friendName
        }
    }
}
