//
//  LikeControl.swift
//  VKClient
//
//  Created by Пазин Даниил on 05.11.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    @IBInspectable var isToggled: Bool = true
    @IBOutlet weak var likeControl: LikeControl!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setStrokeColor(UIColor.red.cgColor)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 12.5, y: 25))
        path.addCurve(to: CGPoint(x: 12.5, y: 15), controlPoint1: CGPoint(x: 0, y: 15), controlPoint2: CGPoint(x: 6.25, y: 0))
        path.addCurve(to: CGPoint(x: 12.5, y: 25), controlPoint1: CGPoint(x: 18.75, y: 0), controlPoint2: CGPoint(x: 25, y: 15))
        path.close()
        path.stroke()
    
    if isToggled {
        let color = UIColor.red
        context.setFillColor(color.cgColor)
    }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGesture()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder )
        
        setupGesture()
        
    }
    
    private func setupGesture() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        addGestureRecognizer(tapGR)
    }
    
    @objc private func tapped(_ tapGesture: UITapGestureRecognizer) {
        isToggled.toggle()
        setNeedsDisplay()
        sendActions(for: .valueChanged)
    }
    
//    override func viewDidLoad() {
//        likeControl.addTarget(self, action: #selector(likeControlChanged), for: .valueChanged)
//    }
//
//    @objc private func likeControlChanged() {
//
//    }
    
}
