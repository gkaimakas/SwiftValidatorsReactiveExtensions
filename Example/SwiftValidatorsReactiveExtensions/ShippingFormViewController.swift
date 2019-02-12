//
//  ShippingFormViewController.swift
//  SwiftValidatorsReactiveExtensions_Example
//
//  Created by George Kaimakas on 12/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MagazineLayout
import SnapKit
import UIKit

class ShippingFormViewController: UIViewController {
    let layout = MagazineLayout()
    var collectionView: UICollectionView!
    
    var dataSource: [SectionType] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        collectionView.bounces = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TextFieldCollectionViewCell.self, forCellWithReuseIdentifier: "TextFieldCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        dataSource = [
            SectionType.rows([
                .field
                ]),
            SectionType.rows([
                .field
                ]),
            SectionType.rows([
                .field,
                .field
                ]),
            SectionType.rows([
                .field
                ]),
            SectionType.rows([
                .field
                ]),
            SectionType.rows([
                .field
                ]),
        ]
    }
}

extension ShippingFormViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.section].value(at: indexPath.item) {
        case .field:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextFieldCollectionViewCell", for: indexPath) as! TextFieldCollectionViewCell
            return cell
        }
    }
}

extension ShippingFormViewController: UICollectionViewDelegateMagazineLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
        
        let widthMode = MagazineLayoutItemWidthMode.fractionalWidth(divisor: UInt(dataSource[indexPath.section].numberOfRows))
        let heightMode = MagazineLayoutItemHeightMode.dynamic
        return MagazineLayoutItemSizeMode(widthMode: widthMode, heightMode: heightMode)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
        return MagazineLayoutHeaderVisibilityMode.hidden
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
        return .hidden
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    }
    
}

extension ShippingFormViewController {
    enum RowType {
        case field
    }
    
    enum SectionType {
        case rows([RowType])
        
        var numberOfRows: Int {
            switch self {
            case .rows(let value):
                return value.count
            }
        }
        
        func value(at index: Int) -> RowType {
            switch self {
            case .rows(let value):
                return value[index]
            }
        }
    }
}
