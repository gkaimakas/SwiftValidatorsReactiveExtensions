//
//  ValidatorOutput.swift
//  Pods
//
//  Created by George Kaimakas on 31/03/2017.
//
//

import Foundation
import ReactiveSwift
import Result
import SwiftValidators

public extension ValidatingProperty.Decision where Value == Optional<StringConvertible> {
    func map<T: StringConvertible>(_ transform: (Value) -> T?) -> ValidatingProperty<T?, ValidationError>.Decision {
        switch self {
        case .valid:
            return .valid
        case .coerced(let value, let error):
            return .coerced(transform(value), error)
        case .invalid(let error):
            return .invalid(error)
        }
    }
}
