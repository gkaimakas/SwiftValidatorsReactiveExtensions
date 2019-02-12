//
//  TextFieldCollectionViewCell.swift
//  SwiftValidatorsReactiveExtensions_Example
//
//  Created by George Kaimakas on 12/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MagazineLayout
import SnapKit
import UIKit

class TextFieldCollectionViewCell: MagazineLayoutCollectionViewCell {
    let titleLabel = UILabel(frame: .zero)
    let textField = UITextField(frame: .zero)
    let errorLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(errorLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(textField.snp.top)
        }
        
        textField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(errorLabel.snp.top)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        errorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        textField.borderStyle = .roundedRect
        
        titleLabel.text = "title"
        textField.placeholder = "text field"
        errorLabel.text = "error"
    }
}
