//
//  MyFriendProfileController.swift
//  VKClient
//
//  Created by Пазин Даниил on 27.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class MyFriendProfileController: UICollectionViewController {
    
    var vkApi = VKApi()
    var friendPhotos = [FriendPhotosItem]()
    var friendID: Int? {
        didSet {
            loadUserPhotos()
        }
    }
    var friendImage: UIImage? = UIImage()
    //
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserPhotos()
    }
    
    func loadUserPhotos() {
        if let friendID = friendID {
            vkApi.loadUserPhotos(token: Session.instance.token, friendID: friendID) { [weak self] _ in
                self?.addPhotos()
                print("!!!!!!!!!!!!!\(self?.friendPhotos)")
            }
        }
    }
    
    // Добавление фотографий в массив friendPhotos.
    func addPhotos() {
        let allPhotos = self.realm.objects(FriendPhotosItem.self)
        for i in 0..<allPhotos.count {
            let photos = allPhotos[i]
            self.friendPhotos.append(photos)
        }
    }
    
    
    
    
    
    
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return friendPhotos.count
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
