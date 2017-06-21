//
//  Validator+ReactiveSwift.swift
//  Pods
//
//  Created by George Kaimakas on 31/03/2017.
//
//

import Foundation
import ReactiveSwift
import Result
import SwiftValidators

public func + (lhs: ValidatorOutput<StringConvertible?, ValidationError>,
               rhs: ValidatorOutput<StringConvertible?, ValidationError>) -> ValidatorOutput<StringConvertible?, ValidationError> {
    
    switch (lhs, rhs){
    case (.valid, .valid):
        return .valid
    case (.valid, .coerced(let value, let error)):
        return .coerced(value, error)
    case (.valid, .invalid(let error)):
        return .invalid(error)
        
    case (.invalid(let error), .valid):
        return .invalid(error)
    case (.invalid(let error), .coerced):
        return .invalid(error)
    case (.invalid(let error), .invalid):
        return .invalid(error)
        
    case (.coerced(let value, let error), .valid):
        return .coerced(value, error)
    case (.coerced(let valueA, let errorA), .coerced(_, _)):
        return .coerced(valueA, errorA)
    case (.coerced(_, _), .invalid(let errorB)):
        return .invalid(errorB)
    default:
        return .invalid(.notSpecified)
    }
}


extension Validator: ReactiveExtensionsProvider {}

public extension Reactive where Base: Validator {
    
    
    /**
     Checks if the seed contains the value
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func contains(_ string: String, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.contains(string, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.contains(string))
        }
    }
    
    /**
     Checks if the seed is equal to the value
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ string: String, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.equals(string, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(string))
        }
    }
    
    /**
     Checks if the seed is equal to the current value of the property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ property: Property<String?>, defaultValue: String, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(property.value ?? defaultValue))
        }
    }
    
    
    /**
     Checks if the seed is equal to the current value of the mutable property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ property: MutableProperty<String?>, defaultValue: String, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(property.value ?? defaultValue))
        }
    }
    
    
    /**
     Checks if the seed is equal to the current value of the mutable property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ property: ValidatingProperty<String?, ValidationError>, defaultValue: String, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(property.value ?? defaultValue))
        }
    }
    
    /**
     Checks if it has the exact length
     
     - parameter length:
     - returns: ReactiveValidator
     */
    public static func exactLength(_ length: Int, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.exactLength(length, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.exactLength(length))
        }
    }
    
    /**
     Checks if it is a valid ascii string
     
     - returns: ReactiveValidator
     */
    public static func isASCII(nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isASCII(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isASCII)
        }
    }
    
    /**
     Checks if it is after the date
     
     - parameter date: The date to check
     - parameter format: The format of the date. Defaults to `dd/MM/yyyy`
     
     - returns: ReactiveValidator
     */
    public static func isAfter(_ date: String, format: String = "dd/MM/yyyy", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isAfter(date, format: format, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isAfter(date, format))
        }
    }
    
    /**
     Checks if it has only letters
     
     - returns: ReactiveValidator
     */
    public static func isAlpha(nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isAlpha(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isAlpha)
        }
    }
    
    /**
     Checks if it has letters and numbers only
     
     - returns: ReactiveValidator
     */
    public static func isAlphanumeric(nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isAlphanumeric(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isAlphanumeric)
        }
    }
    
    /**
     Checks if it a valid base64 string
     
     - returns: ReactiveValidator
     */
    public static func isBase64(nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isBase64(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isBase64)
        }
    }
    
    /**
     Checks if it is before the date
     
     - parameter date: A date as a string
     - returns: ReactiveValidator
     */
    public static func isBefore(_ date: String, format: String = "dd/MM/yyyy", nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isBefore(date, format: format, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isBefore(date, format))
        }
    }
    
    /**
     Checks if it is boolean
     
     - returns: ReactiveValidator
     */
    public static func isBool(nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isBool(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isBool)
        }
    }
    
    /**
     Checks if it is a credit card number
     
     - returns: ReactiveValidator
     */
    public static func isCreditCard(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isCreditCard(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isCreditCard)
        }
    }
    
    /**
     Checks if it is a valid date
     
     - parameter format: The expected format of the date. Defaults to `dd/MM/yyyy`
     
     - returns: ReactiveValidator
     
     */
    public static func isDate(_ format: String = "dd/MM/yyyy", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isDate(format, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isDate(format))
        }
    }
    
    /**
     Checks if it is an email
     
     - returns: ReactiveValidator
     */
    public static func isEmail(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isEmail(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isEmail)
        }
    }
    
    /**
     Checks if it is an empty string
     
     - returns: ReactiveValidator
     */
    public static func isEmpty(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isEmpty(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isEmpty)
        }
    }
    
    /**
     Checks if it is fully qualified domain name
     
     - parameter options: An instance of FDQNOptions
     - returns: ReactiveValidator
     */
    public static func isFQDN(_ options: FQDNOptions = FQDNOptions.defaultOptions, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isFQDN(options, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isFQDN(options))
        }
    }
    
    /**
     Checks if it is false
     
     - returns: ReactiveValidator
     */
    public static func isFalse(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isFalse(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isFalse)
        }
    }
    
    /**
     Checks if it is a float number
     
     - returns: ReactiveValidator
     */
    public static func isFloat(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isFloat(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isFloat)
        }
    }
    
    /**
     Checks if it is a hexadecimal value
     
     - returns: ReactiveValidator
     */
    public static func isHexadecimal(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isHexadecimal(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isHexadecimal)
        }
    }
    
    /**
     Checks if it is a valid hex color
     
     - returns: ReactiveValidator
     */
    public static func isHexColor(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isHexColor(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isHexColor)
        }
    }
    
    /**
     Checks if it is a valid IP (v4 or v6)
     
     - returns: ReactiveValidator
     */
    public static func isIP(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isIP(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIP)
        }
    }
    
    /**
     Checks if it is a valid IPv4
     
     - returns: ReactiveValidator
     */
    public static func isIPv4(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isIPv4(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIPv4)
        }
    }
    
    /**
     Checks if it is a valid IPv6
     
     - returns: ReactiveValidator
     */
    public static func isIPv6(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isIPv6(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIPv6)
        }
    }
    
    /**
     Checks if it is a valid ISBN
     
     - parameter version: ISBN version "10" or "13"
     - returns: ReactiveValidator
     */
    public static func isISBN(_ version: ISBN, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isISBN(version, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isISBN(version))
        }
    }
    
    /**
     Checks if the value exists in the supplied array
     
     - parameter array: An array of strings
     - returns: ReactiveValidator
     */
    public static func isIn(_ array: Array<String>, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isIn(array, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIn(array))
        }
    }
    /**
     Checks if it is a valid integer
     
     - returns: ReactiveValidator
     */
    public static func isInt(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isInt(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isInt)
        }
    }
    
    
    /**
     Checks if it only has lowercase characters
     
     - returns: ReactiveValidator
     */
    public static func isLowercase(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isLowercase(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isLowercase)
        }
    }
    
    /**
     Checks if it is a hexadecimal mongo id
     
     - returns: ReactiveValidator
     */
    public static func isMongoId(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isMongoId(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isMongoId)
        }
    }
    
    /**
     Checks if it is nil
     
     - returns: ReactiveValidator
     */
    
    public static func isNil() -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isNil().apply(value)
                ? .valid
                : .invalid(.isNil)
        }
    }
    
    /**
     Checks if it is numeric
     
     - returns: ReactiveValidator
     */
    public static func isNumeric(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isNumeric(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isNumeric)
        }
    }
    
    /**
     Checks if is is a valid phone
     
     - parameter locale: The locale as a String. Available locales are 'zh-CN', 'en-ZA', 'en-AU', 'en-HK', 'pt-PT', 'fr-FR', 'el-GR', 'en-GB', 'en-US', 'en-ZM', 'ru-RU
     - returns: ReactiveValidator
     */
    public static func isPhone(_ locale: Phone, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isPhone(locale, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isPhone(locale))
        }
    }
    
    /**
     Checks if postal code is valid
     
     - parameter country code:
     - returns ReactiveValidator
     */
    public static func isPostalCode(_ countryCode: PostalCode, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isPostalCode(countryCode, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isPostalCode(countryCode))
        }
    }
    
    /**
     Checks if it is true
     
     - returns: ReactiveValidator
     */
    public static func isTrue(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isTrue(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isTrue)
        }
    }
    
    /**
     Checks if it is a valid UUID
     
     - returns: ReactiveValidator
     */
    public static func isUUID(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isUUID(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isUUID)
        }
    }
    
    /**
     Checks if it has only uppercase letters
     
     - returns: ReactiveValidator
     */
    public static func isUppercase(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.isUppercase(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isUppercase)
        }
    }
    
    /**
     Checks if the length does not exceed the max length
     
     - parameter length: The max length
     - returns: ReactiveValidator
     */
    public static func maxLength(_ length: Int, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.maxLength(length, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.maxLength(length))
        }
    }
    
    /**
     Checks if the length isn't lower than
     
     - parameter length: The min length
     - returns: ReactiveValidator
     */
    public static func minLength(_ length: Int, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.minLength(length, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.minLength(length))
        }
    }
    
    /**
     check if the value fullfils the pattern. The value is matched from start to finish with the regex.
     
     - parameter pattern: The regex to check
     - returns: ReactiveValidator
     */
    public static func regex(_ pattern: String, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.regex(pattern, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.regex(pattern))
        }
    }
    
    
    /**
     Checks if it is not an empty string
     
     - returns: ReactiveValidator
     */
    
    public static func required(nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.required(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.required)
        }
    }
    
    /**
     Checks if the seed is equal to the current value of the property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func watchEquals(tag: String, property: Property<String?>, defaultValue: String, nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.watchEquals(tag, property.value ?? defaultValue))
        }
    }
    
    /**
     Checks if the seed is equal to the current value of the mutable property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func watchEquals(tag: String,
                                   property: MutableProperty<String?>,
                                   defaultValue: String, nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.watchEquals(tag, property.value ?? defaultValue))
        }
    }
    
    /**
     Checks if the seed is equal to the current value of the validating property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func watchEquals(tag: String,
                                   property: ValidatingProperty<String?, ValidationError>,
                                   defaultValue: String,
                                   nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatorOutput<StringConvertible?, ValidationError> in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.watchEquals(tag, property.value ?? defaultValue))
        }
    }
    
    
}
