//
//  LoadView.swift
//  VKClient
//
//  Created by Пазин Даниил on 23.11.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class LoadView: UIView {

    @IBOutlet weak var downloadBallView1: UIView!
    @IBOutlet weak var downloadBallView2: UIView!
    @IBOutlet weak var downloadBallView3: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        downloadBallView1.layer.cornerRadius = bounds.height/2
        downloadBallView2.layer.cornerRadius = bounds.height/2
        downloadBallView3.layer.cornerRadius = bounds.height/2
    }

}
