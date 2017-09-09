//
//  ErrorTableViewCell.swift
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

public class ErrorTableViewCell: UITableViewCell {
    public static let identifier = String(describing: ErrorTableViewCell.self)
    @IBOutlet weak var errorLabel: UILabel!
    
    public var validatingProperty: ValidatingProperty<String?, ValidationError>? {
        didSet {
            guard let validatingProperty = validatingProperty else {
                return
            }
            
            errorLabel.reactive.text <~ validatingProperty
                .result
                .producer
                .take(during: reactive.lifetime)
                .take(until: reactive.prepareForReuse)
                .map({ result -> String? in
                    switch result {
                    case .invalid(_, let error):
                        return "\(error)"
                    default:
                        return nil
                    }
                })
        }
    }
}
