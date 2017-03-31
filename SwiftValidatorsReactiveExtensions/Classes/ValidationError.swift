//
//  ValidationError.swift
//  Pods
//
//  Created by George Kaimakas on 31/03/2017.
//
//


import Foundation
import SwiftValidators

public enum ValidationError: Error {
    case notSpecified
    case contains(String)
    case equals(String)
    case exactLength(Int)
    case isASCII
    case isAfter(String, String)
    case isAlpha
    case isAlphanumeric
    case isBase64
    case isBefore(String, String)
    case isBool
    case isCreditCard
    case isDate(String)
    case isEmail
    case isEmpty
    case isFQDN(FQDNOptions)
    case isFalse
    case isFloat
    case isHexadecimal
    case isHexColor
    case isIP
    case isIPv4
    case isIPv6
    case isISBN(ISBN)
    case isIn([String])
    case isInt
    case isLowercase
    case isMongoId
    case isNil
    case isNumeric
    case isPhone(Phone)
    case isPostalCode(PostalCode)
    case isTrue
    case isUUID
    case isUppercase
    case maxLength(Int)
    case minLength(Int)
    case regex(String)
    case required
}
