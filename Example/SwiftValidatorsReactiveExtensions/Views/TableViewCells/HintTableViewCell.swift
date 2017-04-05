//
//  HintTableViewCell.swift
//  SwiftValidatorsReactiveExtensions
//
//  Created by George Kaimakas on 05/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

public class HintTableViewCell: UITableViewCell {
    public static let identifier = String(describing: HintTableViewCell.self)
    
    @IBOutlet weak var hintLabel: UILabel!
    
    public var hint: SignalProducer<String?, NoError>? {
        didSet {
            guard let hint = hint else {
                return
            }
            
            hintLabel.reactive.text <~ hint
                .take(during: reactive.lifetime)
                .take(until: reactive.prepareForReuse)
        }
    }
}
