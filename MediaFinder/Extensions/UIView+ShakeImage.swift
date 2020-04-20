//
//  UIView+ShakeImage.swift
//  MediaFinder
//
//  Created by Ziad on 4/17/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shake(_ duration: Double? = 0.1){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration!
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
