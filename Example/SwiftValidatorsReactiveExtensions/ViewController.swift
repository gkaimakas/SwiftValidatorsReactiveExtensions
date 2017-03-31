//
//  ViewController.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by gkaimakas on 03/31/2017.
//  Copyright (c) 2017 gkaimakas. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Result
import SwiftValidators
import SwiftValidatorsReactiveExtensions
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    private var email: ValidatingProperty<String?, ValidationError>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        email <~ textField.reactive.continuousTextValues
        label.reactive.text <~ email.result
            .producer
            .map({ (result: ValidationResult<String?, ValidationError>) -> ValidationError? in
                return result.error
            })
            .map({ (result: ValidationError?) -> String? in
                guard let _result = result else { return nil }
                return "\(_result)"
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

