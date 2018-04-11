//
//  ViewController.swift
//  TableViewWithMultipleSelection
//
//  Created by Stanislav Ostrovskiy on 5/22/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var nextButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.allowsMultipleSelection = true
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.separatorStyle = .none
        
    }
    
    @IBAction func next(_ sender: Any) {
        print(viewModel.selectedItemsFirstArray.map { $0.title })
        print(viewModel.selectedItemsSecondArray.map { $0.title })

        tableView?.reloadData()
    }
}
