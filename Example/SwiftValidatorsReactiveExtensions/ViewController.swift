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
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FormViewModel()
    
    var inputs: [FieldViewModel] = []
    var submitView: SumbitView!
    var headerView: HeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputs = [
            viewModel.emailField,
            viewModel.passwordField
        ]
        
        inputs.enumerated().forEach { (offset: Int, element: FieldViewModel) in
            element.hasErrors
                .producer
                .startWithValues({ (value: Bool) in
                    if value == true && self.tableView.numberOfRows(inSection: offset) == 2 {
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: [IndexPath(item: 2, section: offset)], with: .automatic)
                        self.tableView.endUpdates()
                    }
                    
                    if value == false && self.tableView.numberOfRows(inSection: offset) == 3 {
                        self.tableView.beginUpdates()
                        self.tableView.deleteRows(at: [IndexPath(item: 2, section: offset)], with: .automatic)
                        self.tableView.endUpdates()
                    }
                })
        }
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 256))
        headerView.viewModel = viewModel
        
        submitView = SumbitView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        submitView.credentialsAction = viewModel.submit
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 20
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = submitView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return inputs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2 + ( inputs[section].hasErrors.value == true ? 1 : 0)
        }
        
        if section == 1 {
            return 2 + ( inputs[section].hasErrors.value == true ? 1 : 0)
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.identifier) as! HintTableViewCell
            cell.hint = inputs[indexPath.section].hint.producer
            return cell
        }
        
        if indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextInputTableViewCell.identifier) as! TextInputTableViewCell
            cell.validatingProperty = inputs[indexPath.section].validatingProperty
            if indexPath.section == 0 {
                cell.textField.keyboardType = .emailAddress
            } else {
                cell.textField.keyboardType = .default
            }
            
            cell.textField.isSecureTextEntry = (indexPath.section == 1)
            return cell
        }
        
        if indexPath.item == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier) as! ErrorTableViewCell
            cell.validatingProperty = inputs[indexPath.section].validatingProperty
            return cell
        }
        
        return UITableViewCell()
    }
}

