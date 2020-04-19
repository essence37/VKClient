//
//  AllFriendsController.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsController: UITableViewController {
    
    @IBOutlet var tableViewOutlet: UITableView! {
        didSet {
            tableViewOutlet.delegate = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var vkApi = VKApi()
    var database = UserRepository()
    var friends = [User]()
    
//    let friends = UserResponse.toUser.self
    
    var sortedFriends = [Character: [User]]()
    
    override func viewDidLoad() {
           
        tableView.register(UINib(nibName: "FriendXibCell", bundle: nil), forCellReuseIdentifier: "FriendXibCell")
        
        self.sortedFriends = sort(friends: friends)
        
        vkApi.loadUserData(token: Session.instance.token) { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friends = friends
                self?.sortedFriends = (self?.sort(friends: friends))!
//                self?.database.saveUserData(user: friends)
                self?.tableView.reloadData()
            case .failure(_): break
            }
        }

    }
    
    private func sort(friends: [User]) -> [Character: [User]]{
        
        var friendsDic = [Character: [User]]()
        
        friends.forEach { friend in
            guard let firstChar = friend.lastName.first else { return }
            if var thisCharFriends = friendsDic[firstChar] {
                thisCharFriends.append(friend)
                friendsDic[firstChar] = thisCharFriends.sorted { $0.lastName < $1.lastName }
            } else {
                friendsDic[firstChar] = [friend]
            }
        }
        
        return friendsDic
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedFriends.keys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstChar = sortedFriends.keys.sorted()[section]
        return String(firstChar)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = sortedFriends.keys.sorted()
        return sortedFriends[keysSorted[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXibCell", for: indexPath) as? FriendXibCell else {
            preconditionFailure("FriendsCell cannot be dequeued")
        }
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        
        /*
        let friendName = friends[indexPath.row].name
        let friendImage = friends[indexPath.row].image
        cell.friendNameLabel.text = friendName
        cell.friendImageView.image = friendImage
        */
        
        let friend: User = friends[indexPath.row]
        cell.friendNameLabel.text = friend.lastName
        
        // Отобразить картинку с помощью Kingfisher
        let url = URL(string: friend.photo)
        cell.friendImageView.kf.setImage(with: url)
        
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
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> user.self {
//        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
//        let friends = sortedFriends[firstChar]!
//    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Show friend image" {
//            guard let destinationController = segue.destination as? MyFriendProfileController else { return }
//            let index = tableView.indexPathForSelectedRow?.row ?? 0
//            if friends.count > index {
//                let friend = friends[index]
//                destinationController.navigationItem.title = friends.name
//                destinationController.friendImage = friend.photo
//            }
//        }
//    }
//
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         performSegue(withIdentifier: "Show friend image", sender: self)
//    }
}

extension FriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            
        } else {
            
        }
        tableView.reloadData()
    }
}
