//
//  _ReactiveValidator.swift
//  Pods
//
//  Created by George Kaimakas on 31/03/2017.
//
//

import Foundation
import ReactiveSwift
import Result
import SwiftValidators

public class ReactiveValidator {
    public static func combine(_ reactiveValidators: ReactiveValidator ...) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return reactiveValidators
                .map() { $0.apply(value) }
                .reduce(.valid, +)
        }
    }
    
    public static func combine(_ reactiveValidators: [ReactiveValidator]) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return reactiveValidators
                .map() { $0.apply(value) }
                .reduce(.valid, +)
        }
    }
    
    private let validator: (StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision
    public init(_ validator: @escaping (StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision) {
        self.validator = validator
    }
    
    public func apply(_ value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision {
        return self.validator(value)
    }
    
    public func combine(with validator: ReactiveValidator) -> ReactiveValidator {
        return ReactiveValidator.combine(self, validator)
    }
}

