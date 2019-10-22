//
//  Shape.swift
//  MotionCube
//
//  Created by kudakwashe on 2019/10/22.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import Foundation
import UIKit

class Shape: UIView {
    
    var shapeType: String = "circle"
    var collisionType: UIDynamicItemCollisionBoundsType = .rectangle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        if (arc4random_uniform(2) == 0) {
            shapeType = "square"
        }
        backgroundColor = .random()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return collisionType
    }
    
    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            if (self.shapeType == "square") {
                layer.cornerRadius = newBounds.size.width / 2.0
                self.collisionType = .ellipse
            }
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
