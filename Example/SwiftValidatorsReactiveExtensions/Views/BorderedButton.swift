//
//  BorderedButton.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by George Kaimakas on 05/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable
open class BorderedButton: UIButton {
    
    @IBInspectable open var hasBorder: Bool = false
    @IBInspectable open var borderWidth: CGFloat = 2.0
    @IBInspectable open var borderColor: UIColor = UIColor.clear
    
    @IBInspectable open var cornerRadius: CGFloat = 0.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = true
        
        if hasBorder {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
}
