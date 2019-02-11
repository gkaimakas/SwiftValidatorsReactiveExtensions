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
    private let _email: ValidatingProperty<String?, ValidationError>
    private let _password: ValidatingProperty<String?, ValidationError>
    private let _acceptTerms: ValidatingProperty<String?, ValidationError>
    
    public let emailField: FieldViewModel
    public let passwordField: FieldViewModel
    public let acceptTermsField: FieldViewModel
    public var submit: Action<Void, Credentials, NSError>!
    
    public let isValid: Property<Bool>
    
    public init() {
        _email = ValidatingProperty<String?, ValidationError>(nil, { (value: String?) -> ValidatingProperty<String?, ValidationError>.Decision in
            
            return ReactiveValidator.combine([
                Validator.reactive.required(),
                Validator.reactive.isEmail(),
                Validator.reactive.minLength(3, tag: "1"),
                Validator.reactive.maxLength(32)
                ])
                .apply(value)
                .map { $0 as? String }
        })
        
        _password = ValidatingProperty<String?, ValidationError>(nil, { (value: String?) -> ValidatingProperty<String?, ValidationError>.Decision in
            
            return ReactiveValidator.combine([
                Validator.reactive.required(),
                Validator.reactive.minLength(8),
                Validator.reactive.maxLength(32)
                ])
                .apply(value)
                .map { $0 as? String }
        })
        
        _acceptTerms = ValidatingProperty<String?, ValidationError>(nil, { (value: String?) -> ValidatingProperty<String?, ValidationError>.Decision in
            
            return ReactiveValidator.combine([
                Validator.reactive.required(),
                Validator.reactive.isBool(),
                Validator.reactive.isTrue()
                ])
                .apply(value)
                .map { $0 as? String }
        })
        
        let isEmailValid: Property<Bool> = _email.result.map { result -> Bool in
            switch result {
            case .valid(_) :
                return true
            default:
                return false
            }
        }
        
        let isPasswordValid: Property<Bool> = _password.result.map { result -> Bool in
            switch result {
            case .valid(_) :
                return true
            default:
                return false
            }
        }
        
        isValid = isEmailValid.and(isPasswordValid)
        
        emailField = FieldViewModel(id: 0, hint: "email", validatingProperty: _email)
        passwordField = FieldViewModel(id: 1, hint: "password", validatingProperty: _password)
        acceptTermsField = FieldViewModel(id: 2, hint: "accept terms", validatingProperty: _acceptTerms)
        
        let state = Property.combineLatest(
            _email,
            _password,
            isValid
        )
        
        submit = Action<Void, Credentials, NSError>(state: state, enabledIf: { $0.2 == true }) { (state, _) -> SignalProducer<Credentials, NSError> in
                guard let email = state.0,
                    let password = state.1 else {
                        return SignalProducer.empty
                }
                
                return SignalProducer.init(value: Credentials(email: email, password: password))
                    .delay(5, on: QueueScheduler.main)
        }
    }
}
