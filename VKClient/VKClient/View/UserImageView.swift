//
//  UserImageView.swift
//  VKClient
//
//  Created by Пазин Даниил on 02.11.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//
import UIKit

class UserImageView: UIView {
   
    @IBOutlet var userImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = bounds.height/2
    }
    
    
    
//    override func draw(_ rect: CGRect) {
//        let maskLayer = CAShapeLayer()
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
//        maskLayer.path = circlePath.cgPath
//        maskLayer.fillColor = UIColor.clear.cgColor
//    }
    
   
}
