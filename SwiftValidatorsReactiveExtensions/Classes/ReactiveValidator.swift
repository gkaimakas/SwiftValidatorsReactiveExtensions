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
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return reactiveValidators
                .map() { $0.apply(value) }
                .reduce(.valid, +)
        }
    }
    
    public static func combine(_ reactiveValidators: [ReactiveValidator]) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return reactiveValidators
                .map() { $0.apply(value) }
                .reduce(.valid, +)
        }
    }
    
    private let validator: (StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError>
    
    public init(_ validator: @escaping (StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError>) {
        self.validator = validator
    }
    
    public func apply(_ value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> {
        return self.validator(value)
    }
    
    public func combine(with validator: ReactiveValidator) -> ReactiveValidator {
        return ReactiveValidator.combine(self, validator)
    }
}

