//
//  Credentials.swift
//  SwiftValidatorsReactiveExtensions_Example
//
//  Created by George Kaimakas on 11/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

public struct Credentials {
    public let email: String
    public let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
