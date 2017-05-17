//
//  UIImageView.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by George Kaimakas on 05/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//


import Foundation
import UIKit

extension UIView {
    func bordered(width: CGFloat, color: UIColor = UIColor.clear) {
        self.layoutIfNeeded()
        self.layer.cornerRadius = min(self.bounds.height, bounds.width)/2
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
        self.layoutIfNeeded()
    }
}
