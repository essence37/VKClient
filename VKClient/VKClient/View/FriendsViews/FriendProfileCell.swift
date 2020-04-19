//
//  FriendProfileCell.swift
//  VKClient
//
//  Created by Пазин Даниил on 27.10.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class FriendProfileCell: UICollectionViewCell {
    @IBOutlet weak var friendProfileImageView: UIImageView!
    @IBOutlet var likeControl: LikeControl!
    
    public func configureLikeControl(likes count: Int, isLikedByUser: Bool) {
        likeControl.configure(likes: count, isLikedByUser: isLikedByUser)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendProfileImageView.image = nil
    }
    
    
}
