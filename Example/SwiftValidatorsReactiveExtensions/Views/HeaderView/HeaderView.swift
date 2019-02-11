//
//  HeaderView.swift
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

public class HeaderView: UIView {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftImageViewXConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageViewXConstraint: NSLayoutConstraint!
    
    var viewModel: FormViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
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
        let view: UIView? = Bundle(for: HeaderView.self)
            .loadNibNamed(String(describing: HeaderView.self), owner: self, options: nil)?.last as? UIView
        
        if let view = view {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(view)
        }
        
        self.backgroundColor = UIColor.clear
        self.leftImageView.bordered(width: 1)
        self.rightImageView.bordered(width: 1)
    }
}
