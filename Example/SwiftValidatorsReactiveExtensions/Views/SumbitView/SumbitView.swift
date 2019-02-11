//
//  SumbitView.swift
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

public class SumbitView: UIView {
    @IBOutlet weak var button: UIButton!
    
    public var credentialsAction: Action<Void, FormViewModel.Credentials, NSError>? {
        didSet {
            guard let action = credentialsAction else {
                return
            }
            
            button.reactive.isEnabled <~ action.isEnabled
            button.reactive.pressed = CocoaAction(action)
            button.reactive.backgroundColor <~ action.isEnabled
                .producer
                .map({ (enabled: Bool) -> UIColor in
                    return enabled ? UIColor.lightGray : UIColor.white
                })
            
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.white, for: .disabled)
            
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        let view: UIView? = Bundle(for: SumbitView.self)
            .loadNibNamed(String(describing: SumbitView.self), owner: self, options: nil)?.last as? UIView
        
        if let view = view {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(view)
        }
        
        self.backgroundColor = UIColor.clear
    }
}
