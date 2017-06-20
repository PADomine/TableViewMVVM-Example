//
//  UIView+Extension.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 20/6/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}
