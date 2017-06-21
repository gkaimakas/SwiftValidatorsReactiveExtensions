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
    case contains(String, String)
    case equals(String, String)
    case exactLength(String, Int)
    case isASCII(String)
    case isAfter(String, String, String)
    case isAlpha(String)
    case isAlphanumeric(String)
    case isBase64(String)
    case isBefore(String, String, String)
    case isBool(String)
    case isCreditCard(String)
    case isDate(String, String)
    case isEmail(String)
    case isEmpty(String)
    case isFQDN(String, FQDNOptions)
    case isFalse(String)
    case isFloat(String)
    case isHexadecimal(String)
    case isHexColor(String)
    case isIP(String)
    case isIPv4(String)
    case isIPv6(String)
    case isISBN(String, ISBN)
    case isIn(String, [String])
    case isInt(String)
    case isLowercase(String)
    case isMongoId(String)
    case isNil(String)
    case isNumeric(String)
    case isPhone(String, Phone)
    case isPostalCode(String, PostalCode)
    case isTrue(String)
    case isUUID(String)
    case isUppercase(String)
    case maxLength(String, Int)
    case minLength(String, Int)
    case regex(String, String)
    case required(String)
    case watchEquals(String, String)
    
    case custom(String, Error)
}
