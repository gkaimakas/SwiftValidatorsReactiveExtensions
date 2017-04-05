//
//  Reactive+UIButton.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by George Kaimakas on 05/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import UIKit

extension Reactive where Base: UIButton {
    /// Sets the tint color of the button.
    public var tintColor: BindingTarget<UIColor> {
        return makeBindingTarget { $0.tintColor = $1 }
    }
    
}
