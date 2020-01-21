//
//  AllFriendsController.swift
//  VKClient
//
//  Created by Пазин Даниил on 25.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

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
    
    let friends = [Friend
//// было Friend(image: UIImage(named: "Rachel")!, name: "Rachel Green"),
//        Friend(image: (UIImage(named: "Rachel")!), name: "Rachel Green"),
//        Friend(image: (UIImage(named: "Monica")!), name: "Monica Geller-Bing"),
//        Friend(image: (UIImage(named: "Phoebe")!), name: "Phoebe Buffay"),
//        Friend(image: (UIImage(named: "Joey")!), name: "Joey Tribbiani"),
//        Friend(image: (UIImage(named: "Chandler")!), name: "Chandler Bing"),
//        Friend(image: (UIImage(named: "Ross")!), name: "Ross Geller"),
//        
////        ниже: так будет выглядеть с галереей-массивом фотографий, фото f1 f2 загружены в Assets
////        User(image: (UIImage(named: "Ross")!), name: "Ross Geller", photos: [(UIImage(named: "f1")!),(UIImage(named: "f2")!)])
    ]()
    
//    let friends = UserResponse.toUser.self
    
    var sortedFriends = [Character: [Friend]]()
    
    override func viewDidLoad() {
           
        tableView.register(UINib(nibName: "FriendXibCell", bundle: nil), forCellReuseIdentifier: "FriendXibCell")
        
        self.sortedFriends = sort(friends: friends)
        
        vkApi.loadUserData(token: Session.instance.token) { [weak self] (friends: Result<[Friend], Error>) in
            self?.friends = friends
            self?.tableView.reloadData()
        }

    }
    
    private func sort(friends: [Friend]) -> [Character: [Friend]]{
        
        var friendsDic = [Character: [Friend]]()
        
        friends.forEach { friend in
            guard let firstChar = friend.name.first else { return }
            if var thisCharFriends = friendsDic[firstChar] {
                thisCharFriends.append(friend)
                friendsDic[firstChar] = thisCharFriends.sorted { $0.name < $1.name }
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
        let friend: Friend = friends[indexPath.row]
        cell.friendNameLabel.text = friend.name
        cell.friendImageView.image = friend.image
        
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "Show friend image", sender: self)
    }
}

extension FriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            
        } else {
            
        }
        tableView.reloadData()
    }
}
