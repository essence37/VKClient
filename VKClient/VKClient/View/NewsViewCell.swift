//
//  NewsViewCell.swift
//  VKClient
//
//  Created by Пазин Даниил on 21.11.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var likeControl: UIControl!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
