//
//  TableDemoViewController.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/24/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import UIKit

class TableDemoViewController: UIViewController {

    let viewModel: TableDemoViewModel
    let tableView: UITableView
    
    init(viewModel: TableDemoViewModel) {
        self.viewModel = viewModel
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        super.init(nibName: nil, bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Table View Demo"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        self.automaticallyAdjustsScrollViewInsets = false
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["tableView": tableView, "topLayoutGuide": topLayoutGuide]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.rac_command = self.viewModel.addItemButtonActionCommand
        
        RACObserve(target: self.viewModel, keyPath: "addItemButtonIndicator").subscribeNext { [weak self] (flag) in
            if let flag = flag as? Bool , flag == true {
                self?.viewModel.addItem()
            }
        }
        
        RACObserve(target: self.viewModel, keyPath: "items").subscribeNext { (items) in
            self.tableView.reloadData()
        }
        
    }
}

extension TableDemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        cell.textLabel?.text = self.viewModel.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
}
