//
//  FormViewModel.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by George Kaimakas on 05/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import SwiftValidators
import SwiftValidatorsReactiveExtensions

public class FormViewModel {
    public struct Credentials {
        public let email: String
        public let password: String
        
        public init(email: String, password: String) {
            self.email = email
            self.password = password
        }
    }
    
    private let email: ValidatingProperty<String?, ValidationError>
    private let password: ValidatingProperty<String?, ValidationError>
    private let acceptTerms: ValidatingProperty<String?, ValidationError>
    
    public let emailInput: InputViewModel
    public let passwordInput: InputViewModel
    public let acceptTermsInput: InputViewModel
    public var submit: Action<Void, Credentials, NSError>!
    
    public let isValid: Property<Bool>
    
    public init() {
        email = ValidatingProperty<String?, ValidationError>(nil, { (value: String?) -> ValidatorOutput<String?, ValidationError> in
            
            return ReactiveValidator.combine([
                Validator.reactive.required(),
                Validator.reactive.isEmail(),
                Validator.reactive.minLength(3, tag: "1"),
                Validator.reactive.maxLength(32)
                ])
                .apply(value)
                .map { $0 as? String }
        })
        
        password = ValidatingProperty<String?, ValidationError>(nil, { (value: String?) -> ValidatorOutput<String?, ValidationError> in
            
            return ReactiveValidator.combine([
                Validator.reactive.required(),
                Validator.reactive.minLength(8),
                Validator.reactive.maxLength(32)
                ])
                .apply(value)
                .map { $0 as? String }
        })
        
        acceptTerms = ValidatingProperty<String?, ValidationError>(nil, { (value: String?) -> ValidatorOutput<String?, ValidationError> in
            
            return ReactiveValidator.combine([
                Validator.reactive.required(),
                Validator.reactive.isBool(),
                Validator.reactive.isTrue()
                ])
                .apply(value)
                .map { $0 as? String }
        })
        
        let isEmailValid: Property<Bool> = email.result.map { (result: ValidationResult<String?, ValidationError>) -> Bool in
            switch result {
            case .valid(_) :
                return true
            default:
                return false
            }
        }
        
        let isPasswordValid: Property<Bool> = password.result.map { (result: ValidationResult<String?, ValidationError>) -> Bool in
            switch result {
            case .valid(_) :
                return true
            default:
                return false
            }
        }
        
        isValid = Property<Bool>(initial: false, then: SignalProducer.combineLatest([
                isEmailValid.producer,
                isPasswordValid.producer
                ])
                .map { $0.reduce(true) { $0 && $1 } }
        )
        
        emailInput = InputViewModel(id: 0, hint: "email", validatingProperty: email)
        passwordInput = InputViewModel(id: 1, hint: "password", validatingProperty: password)
        acceptTermsInput = InputViewModel(id: 2, hint: "accept terms", validatingProperty: acceptTerms)
        
        submit = Action<Void, Credentials, NSError>(enabledIf: isValid) { _ -> SignalProducer<FormViewModel.Credentials, NSError> in
            
            if let email = self.email.value,
                let password = self.password.value {
                
                return SignalProducer<Credentials, NSError> { (observer, disposable) in
                    let credentials = Credentials(email: email,
                                                  password: password)
                    
                    let timeout = DispatchTime.now() + .seconds(5)
                    DispatchQueue.main.asyncAfter(deadline: timeout, execute: { 
                        observer.send(value: credentials)
                        observer.sendCompleted()
                    })
                }
            }
            
            return SignalProducer.empty
            
            
        }
        
    }
}
