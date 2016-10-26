//
//  LandingViewController.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/24/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    let landingViewModel: LandingViewModel
    
    
    init(viewModel: LandingViewModel) {
        self.landingViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVVM Demo"
        self.view.backgroundColor = UIColor.white
        let loginDemoButton = UIButton()
        loginDemoButton.translatesAutoresizingMaskIntoConstraints = false
        loginDemoButton.setTitleColor(UIColor.black, for: .normal)
        loginDemoButton.backgroundColor = UIColor.lightGray
        loginDemoButton.rac_command = self.landingViewModel.loginDemoButtonCommand
        loginDemoButton.setTitle("Login Demo", for: .normal)
        self.view.addSubview(loginDemoButton)
        
        let tableViewDemoButton = UIButton()
        tableViewDemoButton.translatesAutoresizingMaskIntoConstraints = false
        tableViewDemoButton.setTitleColor(UIColor.black, for: .normal)
        tableViewDemoButton.backgroundColor = UIColor.lightGray
        tableViewDemoButton.rac_command = self.landingViewModel.tableViewDemoButtonCommand
        tableViewDemoButton.setTitle("Table View Demo", for: .normal)
        self.view.addSubview(tableViewDemoButton)
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["loginDemoButton": loginDemoButton, "tableViewDemoButton": tableViewDemoButton, "topLayoutGuide": topLayoutGuide]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[loginDemoButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableViewDemoButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-64-[loginDemoButton(44)]-[tableViewDemoButton(44)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        RACObserve(target: self.landingViewModel, keyPath: "loginDemoButtonPressedIndicator").subscribeNext { (loginDemoFlag) in
            if let flag = loginDemoFlag as? Bool , flag == true {
                let vc = ViewController(viewModel: LoginViewModel())
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        RACObserve(target: self.landingViewModel, keyPath: "tableViewDemoButtonPressedIndicator").subscribeNext { (tableViewDemoFlag) in
            if let flag = tableViewDemoFlag as? Bool , flag == true {
                let vc = TableDemoViewController(viewModel: TableDemoViewModel())
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}
