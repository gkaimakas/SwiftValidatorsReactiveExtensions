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

public extension ValidatorOutput where Value == Optional<StringConvertible>, Error == ValidationError {
    func map<T: StringConvertible>(_ transform: (Value) -> T?) -> ValidatorOutput<T?, Error> {
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
