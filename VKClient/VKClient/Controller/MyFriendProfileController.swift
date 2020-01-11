//
//  MyFriendProfileController.swift
//  VKClient
//
//  Created by Пазин Даниил on 27.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class MyFriendProfileController: UICollectionViewController {
    
    var friendImage: UIImage? = UIImage()
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendProfileCell", for: indexPath) as? FriendProfileCell else { preconditionFailure() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendProfileCell", for: indexPath) as! FriendProfileCell
        /*
        let friendImage = friendAvatar[indexPath.row]?.image
        cell.friendProfileImageView.image = friendImage
        */
        cell.friendProfileImageView.image = friendImage
        
        let count: Int = Int.random(in: 5...500)
        let isLiked: Bool = Bool.random()
        cell.configureLikeControl(likes: count, isLikedByUser: isLiked)
        
        return cell
    }
}
