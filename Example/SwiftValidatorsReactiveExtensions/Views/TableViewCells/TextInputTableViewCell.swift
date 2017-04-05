//
//  TextInputTableViewCell.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by George Kaimakas on 05/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result
import ReactiveSwift
import SwiftValidators
import SwiftValidatorsReactiveExtensions
import UIKit

public class TextInputTableViewCell: UITableViewCell {
    public static let identifier = String(describing: TextInputTableViewCell.self)
    @IBOutlet weak var textField: UITextField!
    
    public var validatingProperty: ValidatingProperty<String?, ValidationError>? {
        didSet {
            guard let validatingProperty = validatingProperty else {
                return
            }
            
            validatingProperty <~ textField
                .reactive
                .continuousTextValues
                .take(during: reactive.lifetime)
                .take(until: reactive.prepareForReuse)
        }
    }
}
