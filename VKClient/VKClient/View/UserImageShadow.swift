//
//  UserImageShadow.swift
//  VKClient
//
//  Created by Пазин Даниил on 02.11.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class UserImageShadow: UIView {
    
    @IBOutlet var userImageShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageShadow.layer.shadowColor = UIColor.black.cgColor
        userImageShadow.layer.cornerRadius = bounds.height/2
        userImageShadow.layer.shadowOffset = .zero
        userImageShadow.layer.shadowRadius = 7
        userImageShadow.layer.shadowOpacity = 0.8
    }
}
