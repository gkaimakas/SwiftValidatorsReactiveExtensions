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

public func + (lhs: ValidatingProperty<StringConvertible?, ValidationError>.Decision,
               rhs: ValidatingProperty<StringConvertible?, ValidationError>.Decision) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision {
    
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
    }
}


extension Validator: ReactiveExtensionsProvider {}

public extension Reactive where Base: Validator {
    
    
    /**
     Checks if the seed contains the value
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func contains(_ string: String,
                                tag: String = "",
                                nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.contains(string, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.contains(tag, string))
        }
    }
    
    /**
     Checks if the seed is equal to the value
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ string: String,
                              tag: String = "",
                              nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.equals(string, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(tag, string))
        }
    }
    
    /**
     Checks if the seed is equal to the current value of the property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ property: Property<String?>,
                              defaultValue: String,
                              tag: String = "",
                              nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(tag, property.value ?? defaultValue))
        }
    }
    
    
    /**
     Checks if the seed is equal to the current value of the mutable property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ property: MutableProperty<String?>,
                              defaultValue: String,
                              tag: String = "",
                              nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(tag, property.value ?? defaultValue))
        }
    }
    
    
    /**
     Checks if the seed is equal to the current value of the mutable property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func equals(_ property: ValidatingProperty<String?, ValidationError>,
                              defaultValue: String,
                              tag: String = "",
                              nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.equals(tag, property.value ?? defaultValue))
        }
    }
    
    /**
     Checks if it has the exact length
     
     - parameter length:
     - returns: ReactiveValidator
     */
    public static func exactLength(_ length: Int, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.exactLength(length, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.exactLength(tag, length))
        }
    }
    
    /**
     Checks if it is a valid ascii string
     
     - returns: ReactiveValidator
     */
    public static func isASCII(tag: String = "", nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isASCII(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isASCII(tag))
        }
    }
    
    /**
     Checks if it is after the date
     
     - parameter date: The date to check
     - parameter format: The format of the date. Defaults to `dd/MM/yyyy`
     
     - returns: ReactiveValidator
     */
    public static func isAfter(_ date: String, format: String = "dd/MM/yyyy", tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isAfter(date, format: format, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isAfter(tag, date, format))
        }
    }
    
    /**
     Checks if it has only letters
     
     - returns: ReactiveValidator
     */
    public static func isAlpha(tag: String = "", nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isAlpha(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isAlpha(tag))
        }
    }
    
    /**
     Checks if it has letters and numbers only
     
     - returns: ReactiveValidator
     */
    public static func isAlphanumeric(tag: String = "", nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isAlphanumeric(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isAlphanumeric(tag))
        }
    }
    
    /**
     Checks if it a valid base64 string
     
     - returns: ReactiveValidator
     */
    public static func isBase64(tag: String = "", nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isBase64(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isBase64(tag))
        }
    }
    
    /**
     Checks if it is before the date
     
     - parameter date: A date as a string
     - returns: ReactiveValidator
     */
    public static func isBefore(_ date: String, format: String = "dd/MM/yyyy", tag: String = "", nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isBefore(date, format: format, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isBefore(tag, date, format))
        }
    }
    
    /**
     Checks if it is boolean
     
     - returns: ReactiveValidator
     */
    public static func isBool(tag: String = "", nilResponse:Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isBool(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isBool(tag))
        }
    }
    
    /**
     Checks if it is a credit card number
     
     - returns: ReactiveValidator
     */
    public static func isCreditCard(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isCreditCard(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isCreditCard(tag))
        }
    }
    
    /**
     Checks if it is a valid date
     
     - parameter format: The expected format of the date. Defaults to `dd/MM/yyyy`
     
     - returns: ReactiveValidator
     
     */
    public static func isDate(_ format: String = "dd/MM/yyyy",
                              tag: String = "",
                              nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isDate(format, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isDate(tag, format))
        }
    }
    
    /**
     Checks if it is an email
     
     - returns: ReactiveValidator
     */
    public static func isEmail(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isEmail(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isEmail(tag))
        }
    }
    
    /**
     Checks if it is an empty string
     
     - returns: ReactiveValidator
     */
    public static func isEmpty(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isEmpty(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isEmpty(tag))
        }
    }
    
    /**
     Checks if it is fully qualified domain name
     
     - parameter options: An instance of FDQNOptions
     - returns: ReactiveValidator
     */
    public static func isFQDN(_ options: FQDNOptions = FQDNOptions.defaultOptions, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isFQDN(options, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isFQDN(tag, options))
        }
    }
    
    /**
     Checks if it is false
     
     - returns: ReactiveValidator
     */
    public static func isFalse(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isFalse(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isFalse(tag))
        }
    }
    
    /**
     Checks if it is a float number
     
     - returns: ReactiveValidator
     */
    public static func isFloat(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isFloat(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isFloat(tag))
        }
    }
    
    /**
     Checks if it is a hexadecimal value
     
     - returns: ReactiveValidator
     */
    public static func isHexadecimal(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isHexadecimal(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isHexadecimal(tag))
        }
    }
    
    /**
     Checks if it is a valid hex color
     
     - returns: ReactiveValidator
     */
    public static func isHexColor(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isHexColor(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isHexColor(tag))
        }
    }
    
    /**
     Checks if it is a valid IP (v4 or v6)
     
     - returns: ReactiveValidator
     */
    public static func isIP(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isIP(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIP(tag))
        }
    }
    
    /**
     Checks if it is a valid IPv4
     
     - returns: ReactiveValidator
     */
    public static func isIPv4(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isIPv4(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIPv4(tag))
        }
    }
    
    /**
     Checks if it is a valid IPv6
     
     - returns: ReactiveValidator
     */
    public static func isIPv6(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isIPv6(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIPv6(tag))
        }
    }
    
    /**
     Checks if it is a valid ISBN
     
     - parameter version: ISBN version "10" or "13"
     - returns: ReactiveValidator
     */
    public static func isISBN(_ version: ISBN, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isISBN(version, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isISBN(tag, version))
        }
    }
    
    /**
     Checks if the value exists in the supplied array
     
     - parameter array: An array of strings
     - returns: ReactiveValidator
     */
    public static func isIn(_ array: Array<String>, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isIn(array, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isIn(tag, array))
        }
    }
    /**
     Checks if it is a valid integer
     
     - returns: ReactiveValidator
     */
    public static func isInt(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isInt(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isInt(tag))
        }
    }
    
    
    /**
     Checks if it only has lowercase characters
     
     - returns: ReactiveValidator
     */
    public static func isLowercase(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isLowercase(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isLowercase(tag))
        }
    }
    
    /**
     Checks if it is a hexadecimal mongo id
     
     - returns: ReactiveValidator
     */
    public static func isMongoId(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isMongoId(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isMongoId(tag))
        }
    }
    
    /**
     Checks if it is nil
     
     - returns: ReactiveValidator
     */
    
    public static func isNil(tag: String = "") -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isNil().apply(value)
                ? .valid
                : .invalid(.isNil(tag))
        }
    }
    
    /**
     Checks if it is numeric
     
     - returns: ReactiveValidator
     */
    public static func isNumeric(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isNumeric(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isNumeric(tag))
        }
    }
    
    /**
     Checks if is is a valid phone
     
     - parameter locale: The locale as a String. Available locales are 'zh-CN', 'en-ZA', 'en-AU', 'en-HK', 'pt-PT', 'fr-FR', 'el-GR', 'en-GB', 'en-US', 'en-ZM', 'ru-RU
     - returns: ReactiveValidator
     */
    public static func isPhone(_ locale: Phone, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isPhone(locale, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isPhone(tag, locale))
        }
    }
    
    /**
     Checks if postal code is valid
     
     - parameter country code:
     - returns ReactiveValidator
     */
    public static func isPostalCode(_ countryCode: PostalCode, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isPostalCode(countryCode, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isPostalCode(tag, countryCode))
        }
    }
    
    /**
     Checks if it is true
     
     - returns: ReactiveValidator
     */
    public static func isTrue(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isTrue(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isTrue(tag))
        }
    }
    
    /**
     Checks if it is a valid UUID
     
     - returns: ReactiveValidator
     */
    public static func isUUID(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isUUID(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isUUID(tag))
        }
    }
    
    /**
     Checks if it has only uppercase letters
     
     - returns: ReactiveValidator
     */
    public static func isUppercase(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.isUppercase(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.isUppercase(tag))
        }
    }
    
    /**
     Checks if the length does not exceed the max length
     
     - parameter length: The max length
     - returns: ReactiveValidator
     */
    public static func maxLength(_ length: Int, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.maxLength(length, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.maxLength(tag, length))
        }
    }
    
    /**
     Checks if the length isn't lower than
     
     - parameter length: The min length
     - returns: ReactiveValidator
     */
    public static func minLength(_ length: Int, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.minLength(length, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.minLength(tag, length))
        }
    }
    
    /**
     check if the value fullfils the pattern. The value is matched from start to finish with the regex.
     
     - parameter pattern: The regex to check
     - returns: ReactiveValidator
     */
    public static func regex(_ pattern: String, tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.regex(pattern, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.regex(tag, pattern))
        }
    }
    
    
    /**
     Checks if it is not an empty string
     
     - returns: ReactiveValidator
     */
    
    public static func required(tag: String = "", nilResponse: Bool = false) -> ReactiveValidator {
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.required(nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.required(tag))
        }
    }
    
    /**
     Checks if the seed is equal to the current value of the property
     
     - parameter seed:
     - returns: ReactiveValidator
     */
    public static func watchEquals(property: Property<String?>,
                                   defaultValue: String,
                                   tag: String = "",
                                   nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
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
    public static func watchEquals(property: MutableProperty<String?>,
                                   defaultValue: String,
                                   tag: String = "",
                                   nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
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
    public static func watchEquals(property: ValidatingProperty<String?, ValidationError>,
                                   defaultValue: String,
                                   tag: String = "",
                                   nilResponse: Bool = false) -> ReactiveValidator {
        
        return ReactiveValidator { (value: StringConvertible?) -> ValidatingProperty<StringConvertible?, ValidationError>.Decision in
            return Validator.equals(property.value ?? defaultValue, nilResponse: nilResponse).apply(value)
                ? .valid
                : .invalid(.watchEquals(tag, property.value ?? defaultValue))
        }
    }
    
    
}
