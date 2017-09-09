//
//  InputViewModel.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by George Kaimakas on 05/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import SwiftValidators
import SwiftValidatorsReactiveExtensions

public class InputViewModel {
    public let id: Property<Int>
    public let hint: Property<String?>
    public let validatingProperty: ValidatingProperty<String?, ValidationError>
    public let hasErrors: Property<Bool>
    
    public init(id: Int, hint: String?, validatingProperty: ValidatingProperty<String?, ValidationError>) {
        self.id = Property(value: id)
        self.hint = Property(value: hint)
        self.validatingProperty = validatingProperty
        
        self.hasErrors = Property<Bool>(initial: false, then: validatingProperty
            .result
            .producer
            .skip(first: 1)
            .map { result -> Bool in
                switch result {
                case .valid(_):
                    return false
                default:
                    return true
                }
        })
    }
    
    public init(id: Int, hint: MutableProperty<String?>, validatingProperty: ValidatingProperty<String?, ValidationError>) {
        
        self.id = Property(value: id)
        self.hint = Property(capturing: hint)
        self.validatingProperty = validatingProperty
        
        self.hasErrors = validatingProperty
            .result
            .map { result -> Bool in
                switch result {
                case .valid(_):
                    return false
                default:
                    return true
                }
        }
    }
    
    
}
