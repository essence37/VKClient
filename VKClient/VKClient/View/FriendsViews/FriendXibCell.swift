//
//  FriendsXibCell.swift
//  VKClient
//
//  Created by Пазин Даниил on 11.11.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class FriendXibCell: UITableViewCell {
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Круглая рамка аватарки друга.
        friendImageView.layer.borderWidth = 1
        friendImageView.layer.masksToBounds = false
        friendImageView.layer.borderColor = UIColor.systemBlue.cgColor
        friendImageView.layer.cornerRadius = friendImageView.frame.height/2
        friendImageView.clipsToBounds = true
        
        
        // Тень для аватарки.
        shadowView.layer.shadowColor = UIColor.systemBlue.cgColor
        shadowView.layer.cornerRadius = bounds.height/2
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.masksToBounds = false
    }
    
    // MARK: - Animations
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { self.friendImageView.bounds.size.height *= 2
        })
    }
    
}
