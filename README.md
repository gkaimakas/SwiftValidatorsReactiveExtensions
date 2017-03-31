# Swift Validators Reactive Extensions :large_orange_diamond:

`ReactiveSwift`'s `ValidatingProperty` is the ideal place to apply SwiftValidators. `SwiftValidatorsReactiveExtensions` provides a set of extensions that make working with `ValidatingProperty` easy.

## Contents
+ [Installation](#installation)
+ [Walkthrough](#walkthrough)
+ [Usage](#usage)
+ [Available validators](#supported-functions)
+ [License](#license-mit)

### Installation

`SwiftValidatorsReactiveExtensions` is available on CocoaPods for iOS 9.0+, Xcode 8 and Swift 3.0

````
pod 'SwiftValidatorsReactiveExtensions'
````

### Walkthrough
#### Usage

`SwiftValidatorsReactiveExtensions` exposes a `reactive` property in `Validator` that maps each available validator to a `ReactiveValidator`. A `ReactiveValidator` can validate a value that conforms to `StringConvertible` and the result will be `ValidatorOutput<StringConvertible?, ValidationError>`.

`ValidationError` is an enum that conform to `Swift.Error` and provides cases for all available validators in `SwiftValidators` and a special case `.notSpecified` for when the error is not specified.

````
Validator.reactive.isEmail().apply("gkaimakas@gmail.com") // returns .valid

Validator.reactive.isEmail().apply("abcd") // returns .invalid(.isEmail)
````

Validation is done using the `apply` function of a `Validator`.
You can create a `Validator` manually or you can use on of the already available via static functions in the Validator class. 

A `Validator`'s apply function accepts an input as a nullable value that conforms to the `StringConvertible` protocol. By default `String`, `NSString`, `Int`, `Float`, `Double` and `Bool` conform to `StringConvertible`.

You can specify the `Validator`'s behaviour when it's input is nil if you are using the static Validator function by setting the `nilResponse` parameter to either true or false. By default nilResponse is set to false.

```swift
Validator.exactLength(3).apply("abc") //returns true

Validator.exactLength(3).apply(true) //returns false (the string representation of true is 'true')

Validator.exactLength(3).apply(nil) //returns false since `nilResponse` is set to false by default

Valuidator.exactLength(3, nilResponse: true).apply(nil) //returns true since we set nilResponse to true
```

For more examples on how to call each validator you can look at the [unit tests](https://github.com/gkaimakas/SwiftValidators/blob/master/SwiftValidatorsTests/ValidatorSpec.swift).

#### Logical Operators

`ReactiveValidator` exposes the `combine` function both as a `static` function and as an `instance` function. The `combine` function is equivalent to a logical and meaning that all validators must be `.valid` for the combined validator to be `.valid`.

````
ReactiveValidator.combine(Validator.reactive.isEmail(), Validator.reactive.isLowercase()) // variadic function

ReactiveValidator.combine([Validator.reactive.isEmail(), Validator.reactive.isLowercase()]) // array arguments

Validator.reactive.isEmail().combine(with: Validator.reactive.isLowercase()) // instance function
````

#### Mapping

`SwiftValidatorsReactiveExtensions` provide a `map` function to map the result of a `ReactiveValidator` ValidatorOutput<StringConvertible?, ValidationError> to the exact ValidatorOutput that the `ValidatingProperty` expects.


````
email = ValidatingProperty<String?, ValidationError>(nil, { (value: String?) -> ValidatorOutput<String?, ValidationError> in
return ReactiveValidator.combine([
Validator.reactive.required(),
Validator.reactive.minLength(5),
Validator.reactive.maxLength(32),
Validator.reactive.isEmail()
])
.apply(value)
.map() { $0 as? String }
})
````

### Available Validators

All the Validators that are available in [`SwiftValidators`](https://github.com/gkaimakas/SwiftValidators#supported-functions).


### License MIT

````
Copyright (c) George Kaimakas gkaimakas@gmail.com

Permission is hereby granted, free of charge, to any person obtaining 
acopy of this software and associated documentation files (the 
"Software"), to deal in the Software without restriction, including 
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to 
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
````
