//
//  MyFriendProfileController.swift
//  VKClient
//
//  Created by Пазин Даниил on 27.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class MyFriendProfileController: UICollectionViewController {
    
    @IBOutlet weak var likeControl: LikeControl!
    
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
        
        return cell
    }
   
       override func viewDidLoad() {
           likeControl.addTarget(self, action: #selector(likeControlChanged), for: .valueChanged)
       }
       
       @objc private func likeControlChanged() {
           
       }
    
}
