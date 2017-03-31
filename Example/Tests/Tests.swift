// https://github.com/Quick/Quick


import Quick
import Nimble
import ReactiveSwift
import Result
import SwiftValidators
import SwiftValidatorsReactiveExtensions
import Foundation

struct ReactiveTestCase {
    let name: String
    let message: String
    let validator: ReactiveValidator
    let valid: [StringConvertible?]
    let invalid: [StringConvertible?]
}

class ReactiveValidatorSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        let ReactiveTestCases: [ReactiveTestCase] = [
            ReactiveTestCase(name: "contains",
                     message: "should validate if the value contains the string",
                     validator: Validator.reactive.contains("some_string"),
                     valid: [
                        "some_string_asfa",
                        "dfsgfsf_Asdafda_some_string"
                ],
                     invalid: [
                        "abc",
                        "sting"
                ]),
            
            ReactiveTestCase(name: "equals",
                     message: "should validate if the value is equal",
                     validator: Validator.reactive.equals("some_string"),
                     valid: [
                        "some_string"
                ],
                     invalid: [
                        "some_other_string",
                        nil
                ]
            ),
            
            ReactiveTestCase(name: "exactLength",
                     message: "should validate if the value has the exact length",
                     validator: Validator.reactive.exactLength(5),
                     valid: [
                        "12345",
                        "abcde",
                        "klmno"
                ],
                     invalid: [
                        String(123),
                        "0",
                        "123"
                ]
            ),
            
            ReactiveTestCase(name: "isASCII", message:
                "should validate if the value contains only ASCII charactes",
                     validator: Validator.reactive.isASCII(),
                     valid: [
                        "foobar",
                        "0987654321",
                        "test@example.com",
                        "1234abcDEF"
                ],
                     invalid: [
                        "ασφαδφ",
                        "ασδαδafad",
                        "13edsaαφδσ",
                        "ｶﾀｶﾅ"
                ]
            ),
            
            ReactiveTestCase(name: "isAfter",
                     message: "should validate if the value is after the date",
                     validator: Validator.reactive.isAfter("25/09/1987"),
                     valid: [
                        "28/03/1994",
                        "29/03/1994"
                ],
                     invalid: [
                        "02/06/1946"
                ]
            ),
            
            ReactiveTestCase(name: "isAlpha",
                     message: "should validate if the value contains only letters",
                     validator: Validator.reactive.isAlpha(),
                     valid: [
                        "asdsdgdfhdfASFSDGDFHFG"
                ],
                     invalid: [
                        "3304193705b2464a98ad3910cbe0d09e",
                        "123",
                        nil
                ]
            ),
            
            ReactiveTestCase(name: "isAlphanumeric",
                     message: "should validate if the value contains only alphanumeric characters",
                     validator: Validator.reactive.isAlphanumeric(),
                     valid: [
                        "abc123",
                        "ABC11"
                ],
                     invalid: [
                        "foo!!",
                        "abc __ __ "
                ]
            ),
            
            ReactiveTestCase(name: "isBase64",
                     message: "should validate that the value is a base64 encoded string",
                     validator: Validator.reactive.isBase64(),
                     valid: [
                        "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4=",
                        "Vml2YW11cyBmZXJtZW50dW0gc2VtcGVyIHBvcnRhLg==",
                        "U3VzcGVuZGlzc2UgbGVjdHVzIGxlbw==",
                        "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuMPNS1Ufof9EW/M98FNw",
                        "UAKrwflsqVxaxQjBQnHQmiI7Vac40t8x7pIb8gLGV6wL7sBTJiPovJ0V7y7oc0Ye",
                        "rhKh0Rm4skP2z/jHwwZICgGzBvA0rH8xlhUiTvcwDCJ0kc+fh35hNt8srZQM4619",
                        "FTgB66Xmp4EtVyhpQV+t02g6NzK72oZI0vnAvqhpkxLeLiMCyrI416wHm5Tkukhx",
                        "QmcL2a6hNOyu0ixX/x2kSFXApEnVrJ+/IxGyfyw8kf4N2IZpW5nEP847lpfj0SZZ",
                        "Fwrd1mnfnDbYohX2zRptLy2ZUn06Qo9pkG5ntvFEPo9bfZeULtjYzIl6K8gJ2uGZ",
                        "HQIDAQAB",
                        ""
                ],
                     invalid: [
                        "12345",
                        "Vml2YW11cyBmZXJtZtesting123"
                ]
            ),
            
            ReactiveTestCase(name: "isBefore",
                     message: "should validate if the value is before the date",
                     validator: Validator.reactive.isBefore("29/03/1994"),
                     valid: [
                        "04/10/1992",
                        "25/09/1987"
                ], invalid: [
                    "30/03/1994"
                ]
            ),
            
            ReactiveTestCase(name: "isBool",
                     message: "should validate if the value is true or false",
                     validator: Validator.reactive.isBool(),
                     valid: [
                        false,
                        true,
                        "true",
                        "false"
                ],
                     invalid: [
                        1,
                        2,
                        3,
                        "one",
                        "on",
                        "off",
                        0
                ]
            ),
            
            ReactiveTestCase(name: "isCreditCard",
                     message: "should validate credit cards",
                     validator: Validator.reactive.isCreditCard(),
                     valid: [
                        "375556917985515",
                        "36050234196908",
                        "4716461583322103",
                        "4716-2210-5188-5662",
                        "4929 7226 5379 7141",
                        "5398228707871527",
                        "5398228707871528",
                        ],
                     invalid: [
                        "foo",
                        "foobar",
                        false
                ]
            ),
            
            ReactiveTestCase(name: "isDate",
                     message: "should validate dates",
                     validator: Validator.reactive.isDate(),
                     valid: [
                        "25/09/1987",
                        "01/01/2000",
                        "29/03/1994",
                        "02/06/1946"
                ], invalid: [
                    "test",
                    false
                ]
            ),
            
            ReactiveTestCase(name: "isEmail",
                     message: "should validate emails",
                     validator: Validator.reactive.isEmail(),
                     valid: [
                        "gkaimakas@gmail.com",
                        "foo@bar.com",
                        "x@x.au",
                        "foo@bar.com.au",
                        "hans.m端ller@test.com",
                        "hans@m端ller.com",
                        "test|123@m端ller.com",
                        "test+ext@gmail.com",
                        "some.name.midd.leNa.me.+extension@GoogleMail.com",
                        "gmail...ignores...dots...@gmail.com"
                ],
                     invalid: [
                        "tester",
                        "invalidemail@",
                        "invalid.com",
                        "@invalid.com",
                        "foo@bar.com.",
                        "foo@bar.co.uk."
                ]
            ),
            
            ReactiveTestCase(name: "isEmpty",
                     message: "should validate empty strings",
                     validator: Validator.reactive.isEmpty(),
                     valid: [
                        ""
                ],
                     invalid: [
                        "not_empty"
                ]
            ),
            
            ReactiveTestCase(name: "isFQDN",
                     message: "should validate FQDN strings",
                     validator: Validator.reactive.isFQDN(),
                     valid: [
                        "domain.com",
                        "dom.plato",
                        "a.domain.co",
                        "foo--bar.com",
                        "xn--froschgrn-x9a.com",
                        "rebecca.blackfriday",
                        "www9.example.com",
                        "www1.exaple.com",
                        "w1w.example12.org"
                ],
                     invalid: [
                        "abc",
                        "256.0.0.0",
                        "_.com",
                        "*.som.com",
                        "s!ome.com",
                        "domain.com/",
                        "/more.com"
                ]
            ),
            
            ReactiveTestCase(name: "isFloat",
                     message: "should validate floats",
                     validator: Validator.reactive.isFloat(),
                     valid: [
                        "1.2",
                        (1.2 as Float),
                        (1 as Double),
                        (1241432 as Double),
                        "123",
                        "123.",
                        "123.123",
                        "-123.123",
                        "-0.123",
                        "+0.123",
                        "0123",
                        ".0",
                        "0123.123",
                        "-0.1233425364353e-307",
                        ""
                ],
                     invalid: [
                        "abc",
                        "___",
                        "0,124"
                ]
            ),
            
            ReactiveTestCase(name: "isHexadecimal",
                     message: "should validate hexadecimals",
                     validator: Validator.reactive.isHexadecimal(),
                     valid: [
                        "deadBEEF",
                        "ff0044"
                ],
                     invalid: [
                        "sgrl",
                        "---",
                        "#,dsfsdf"
                ]
            ),
            
            ReactiveTestCase(name: "isHexColor",
                     message: "should validate hex colors",
                     validator:  Validator.reactive.isHexColor(),
                     valid: [
                        "#ff0034",
                        "#CCCCCC",
                        "fff",
                        "#f00",
                        ],
                     invalid: [
                        "#ff",
                        "ff00",
                        "ff12fg",
                        nil
                ]
            ),
            
            ReactiveTestCase(name: "isIP",
                     message: "should validate IPs",
                     validator: Validator.reactive.isIP(),
                     valid: [
                        "::1",
                        "2001:db8:0000:1:1:1:1:1",
                        "2001:41d0:2:a141::1",
                        "::ffff:127.0.0.1",
                        "::0000",
                        "0000::",
                        "1::",
                        "1111:1:1:1:1:1:1:1",
                        "fe80::a6db:30ff:fe98:e946",
                        "::",
                        "::ffff:127.0.0.1",
                        "0:0:0:0:0:ffff:127.0.0.1",
                        "192.123.23.0"
                ],
                     invalid: [
                        "abc",
                        "256.0.0.0",
                        "0.0.0.256",
                        "26.0.0.256",
                        "::banana",
                        "banana::",
                        "::1::",
                        "1:",
                        ":1",
                        ":1:1:1::2",
                        "1:1:1:1:1:1:1:1:1:1:1:1:1:1:1:1",
                        "::11111",
                        "11111:1:1:1:1:1:1:1",
                        "2001:db8:0000:1:1:1:1::1",
                        "0:0:0:0:0:0:ffff:127.0.0.1",
                        "0:0:0:0:ffff:127.0.0.1",
                        "192.123.23.257"
                ]
            ),
            
            ReactiveTestCase(name: "isIPv4",
                     message: "should validate IPv4 addresses",
                     validator: Validator.reactive.isIPv4(),
                     valid: [
                        "192.123.23.0"
                ],
                     invalid: [
                        "92.123.23.257"
                ]
            ),
            
            ReactiveTestCase(name: "isIPv6",
                     message: "should validate IPv6 addresses",
                     validator: Validator.reactive.isIPv6(),
                     valid: [
                        "::1",
                        "2001:db8:0000:1:1:1:1:1",
                        "2001:41d0:2:a141::1",
                        "::ffff:127.0.0.1",
                        "::0000",
                        "0000::",
                        "1::",
                        "1111:1:1:1:1:1:1:1",
                        "fe80::a6db:30ff:fe98:e946",
                        "::",
                        "::ffff:127.0.0.1",
                        "0:0:0:0:0:ffff:127.0.0.1"
                ],
                     invalid: [
                        "abc",
                        "256.0.0.0",
                        "0.0.0.256",
                        "26.0.0.256",
                        "::banana",
                        "banana::",
                        "::1::",
                        "1:",
                        ":1",
                        ":1:1:1::2",
                        "1:1:1:1:1:1:1:1:1:1:1:1:1:1:1:1",
                        "::11111",
                        "11111:1:1:1:1:1:1:1",
                        "2001:db8:0000:1:1:1:1::1",
                        "0:0:0:0:0:0:ffff:127.0.0.1",
                        "0:0:0:0:ffff:127.0.0.1",
                        "192.123.23.257"
                ]
            ),
            
            ReactiveTestCase(name: "isISBN(10)",
                     message: "should validate ISBNs v 10",
                     validator: Validator.reactive.isISBN(.v10),
                     valid: [
                        "3836221195",
                        "1617290858",
                        "0007269706",
                        "3423214120",
                        "340101319X",
                        "3-8362-2119-5",
                        "1-6172-9085-8",
                        "0-0072-6970-6",
                        "3-4232-1412-0",
                        "3-4010-1319-X",
                        "3 8362 2119 5",
                        "1 6172 9085 8",
                        "0 0072 6970 6",
                        "3 4232 1412 0",
                        "3 4010 1319 X",
                        ],
                     invalid: [
                        "3423214121",
                        "978-3836221191",
                        "123456789a",
                        "3-423-21412-1",
                        "9783836221191",
                        "foo",
                        "3 423 21412 1"
                ]
            ),
            
            ReactiveTestCase(name: "isISBN(13)",
                     message: "should validate ISBNS v13",
                     validator: Validator.reactive.isISBN(.v13),
                     valid: [
                        "9783836221191",
                        "978-3-8362-2119-1",
                        "978 3 8362 2119 1",
                        "9783401013190",
                        "978-3401013190",
                        "978 3401013190",
                        "9784873113685",
                        "978-4-87311-368-5",
                        "978 4 87311 368 5"
                ],
                     invalid: [
                        "9783836221190",
                        "3836221195",
                        "01234567890ab"
                ]
            ),
            
            ReactiveTestCase(name: "isIn",
                     message: "should validate that the value exists in the array",
                     validator: Validator.reactive.isIn(["one", "two", "three"]),
                     valid: [
                        "one",
                        "two",
                        "three"
                ],
                     invalid: [
                        1,
                        2,
                        3,
                        "oneee"
                ]
            ),
            
            ReactiveTestCase(name: "isInt",
                     message: "should validate ints",
                     validator: Validator.reactive.isInt(),
                     valid: [
                        1,
                        2,
                        3,
                        -1230,
                        -1234444
                ],
                     invalid: [
                        "a134",
                        123.2,
                        -4354.546
                ]
            ),
            
            ReactiveTestCase(name: "isLowercase",
                     message: "should validate lowercase strings",
                     validator: Validator.reactive.isLowercase(),
                     valid: [
                        "aaaaaa a a aa  aa"
                ]
                , invalid: [
                    "aA_asfaf",
                    "aaaa aaa A"
                ]
            ),
            
            ReactiveTestCase(name: "isMongoId",
                     message: "should validate hexadecimal mongo ids",
                     validator: Validator.reactive.isMongoId(),
                     valid: [
                        "507f1f77bcf86cd799439011"
                ],
                     invalid: [
                        "507f1f77bcf86cd7994390",
                        "507f1f77bcf86cd79943901z"
                ]
            ),
            
            ReactiveTestCase(name: "isNumeric",
                     message: "should validate numeric values",
                     validator: Validator.reactive.isNumeric(),
                     valid: [
                        123,
                        00123,
                        "00123",
                        0,
                        "-0",
                        "+123"
                ],
                     invalid: [
                        "+213 12"
                ]
            ),
            
            ReactiveTestCase(name: "isPhone_el_GR",
                     message: "should validate phone numbers from Greece",
                     validator: Validator.reactive.isPhone(.el_GR),
                     valid: [
                        "2101231231",
                        "6944848966",
                        "6944114280",
                        "6978989652",
                        "6970310751"
                ],
                     invalid: [
                        "1231341412"
                ]
            ),
            
            ReactiveTestCase(name: "isPhone_nl_BE",
                     message: "should validate phone numbers from Belgium",
                     validator: Validator.reactive.isPhone(.nl_BE),
                     valid: [
                        "0123456789",
                        "0032123456789",
                        "+32123456789"
                ],
                     invalid: [
                        "1234567890",
                        "0412345678",
                        "+31123456789",
                        "01234567890"
                ]
            ),
            
            ReactiveTestCase(name: "isPhone_nl_BE_mobile",
                     message: "should validate phone numbers from Belgian mobile phones",
                     validator: Validator.reactive.isPhone(.nl_BE_mobile),
                     valid: [
                        "04123456789",
                        "00324123456789",
                        "+324123456789",
                        ],
                     invalid: [
                        "1234567890",
                        "0412345678",
                        "+31123456789",
                        "01234567890"
                ]
            ),
            
            ReactiveTestCase(name: "isPhone_nl_NL",
                     message: "should validate phone numbers from The Netherlands",
                     validator: Validator.reactive.isPhone(.nl_NL),
                     valid: [
                        "0123456789",
                        "0031123456789",
                        "+31123456789"
                ],
                     invalid: [
                        "012345678",
                        "1234567890",
                        "+311234567890"
                ]
            ),
            
            ReactiveTestCase(name: "isPostalCode_BE",
                     message: "should validate Belgian postal codes",
                     validator: Validator.reactive.isPostalCode(.BE),
                     valid: [
                        "1000",
                        "9999"
                ],
                     invalid: [
                        "123",
                        "123456",
                        "ABCDAB"
                ]
            ),
            
            ReactiveTestCase(name: "isPostalCode_GB",
                     message: "should validate British postal codes",
                     validator: Validator.reactive.isPostalCode(.GB),
                     valid: [
                        "B45 0HY",
                        "CV32 7NG",
                        "HD5 8UR"
                ],
                     invalid: [
                        "1234",
                        "1234A",
                        "ABCDAB"
                ]
            ),
            
            ReactiveTestCase(name: "isPostalCode_NL",
                     message: "should validate Dutch postal codes",
                     validator: Validator.reactive.isPostalCode(.NL),
                     valid: [
                        "5171KW",
                        "1234 AB"
                ],
                     invalid: [
                        "1234",
                        "1234A",
                        "ABCDAB"
                ]
            ),
            
            ReactiveTestCase(name: "isPostalCode_US",
                     message: "should validate United-States postal codes",
                     validator: Validator.reactive.isPostalCode(.US),
                     valid: [
                        "90201"
                ],
                     invalid: [
                        "1234",
                        "1234A",
                        "1234AB",
                        "ABCDAB"
                ]
            ),
            
            ReactiveTestCase(name: "isTrue",
                     message: "should validate true",
                     validator: Validator.reactive.isTrue(),
                     valid: [
                        true,
                        "true"
                ],
                     invalid: [
                        false,
                        "false"
                ]
            ),
            
            ReactiveTestCase(name: "isUUID",
                     message: "should validate UUIDs",
                     validator: Validator.reactive.isUUID(),
                     valid: [
                        "33041937-05b2-464a-98ad-3910cbe0d09e",
                        UUID().uuidString
                ],
                     invalid: [
                        "3304193705b2464a98ad3910cbe0d09e",
                        "123"
                ]
            ),
            
            ReactiveTestCase(name: "isUppercase",
                     message: "should validate uppercase values",
                     validator: Validator.reactive.isUppercase(),
                     valid: [
                        "AAAAAAA"
                ],
                     invalid: [
                        "AAAAAAAaaa"
                ]
            ),
            
            ReactiveTestCase(name: "maxLength",
                     message: "should validate values that do not exceed the max length",
                     validator: Validator.reactive.maxLength(5),
                     valid: [
                        1,
                        12,
                        123,
                        1234,
                        12345,
                        "abced"
                ],
                     invalid: [
                        123456,
                        "abcdef"
                ]
            ),
            
            ReactiveTestCase(name: "minLength",
                     message: "should validate values that exceed the min length",
                     validator: Validator.reactive.minLength(2),
                     valid: [
                        12,
                        1234,
                        123,
                        1234577
                ],
                     invalid: [
                        1,
                        ""
                ]
            ),
            
            ReactiveTestCase(name: "required",
                     message: "should validate values that are not empty",
                     validator: Validator.reactive.required(),
                     valid: [
                        " ",
                        1234
                ],
                     invalid: [
                        "",
                        nil
                ]
            )
        ]
        
        for reactiveTestCase in ReactiveTestCases {
            describe(reactiveTestCase.name) {
                it(reactiveTestCase.message) {
                    for value in reactiveTestCase.valid {
                        var result: Bool = false
                        switch reactiveTestCase.validator.apply(value) {
                        case .valid:
                            result = true
                        default:
                            result = false
                        }
                        
                        expect(result).to(equal(true))
                    }
                    for value in reactiveTestCase.invalid {
                        var result: Bool = false
                        switch reactiveTestCase.validator.apply(value) {
                        case .invalid(_):
                            result = true
                        default:
                            result = false
                        }
                        expect(result).to(equal(true))
                    }
                }
            }
        }
    }
}
