//
//  ViewController.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/9/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    let viewModel: LoginViewModel
    let activityIndicatorView: UIActivityIndicatorView
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        // An UIActivityIndicatorView which will begin animating while API request is in progress.
        self.activityIndicatorView = UIActivityIndicatorView()
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
        self.activityIndicatorView.color = UIColor.green
        self.activityIndicatorView.hidesWhenStopped = true
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login";
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.activityIndicatorView)
        
        // Input fields. Viz. First and Last name.
        let firstNameField = UITextField()
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        firstNameField.placeholder = "First Name"
        firstNameField.borderStyle = UITextBorderStyle.line
        self.view.addSubview(firstNameField)
        
        let lastNameField = UITextField()
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        lastNameField.placeholder = "Last Name"
        lastNameField.borderStyle = UITextBorderStyle.line
        self.view.addSubview(lastNameField)

        // A login button associated with login screen.
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.layer.borderColor = UIColor.lightGray.cgColor;
        loginButton.layer.borderWidth = 1.0;
        loginButton.setTitle("Login", for: .normal)
        loginButton.rac_command = self.viewModel.loginButtonCommandAction;
        self.view.addSubview(loginButton)

        // A label to show the details of logged in user.
        let loggedInUserDetails = UILabel()
        loggedInUserDetails.translatesAutoresizingMaskIntoConstraints = false;
        loggedInUserDetails.textAlignment = NSTextAlignment.center;
        loggedInUserDetails.numberOfLines = 0;
        self.view.addSubview(loggedInUserDetails)

        // We keep an observer on loginInputValid property associated with JKLoginViewModel viewModel. This property will indicate view if user provided inputs are valid or not.
        RACObserve(target: self.viewModel, keyPath: "loginInputValid").subscribeNext { (x) in
            if let x = x as? Bool {
                loginButton.isEnabled = x
                loginButton.alpha = x == true ? 1.0 : 0.5
            }
        }

        // Bind the user provided inputs to viewModel properties.
        firstNameField.rac_textSignal().subscribeNext({ (firstName) in
            if let firstName = firstName as? String {
                self.viewModel.firstName = firstName
            }
        })
        
        lastNameField.rac_textSignal().subscribeNext({ (lastName) in
            if let lastName = lastName as? String {
                self.viewModel.lastName = lastName
            }
        })
        
        _ = RACObserve(target: self.viewModel, keyPath: "loggedInUser").ignore(nil)?.subscribeNext({ (x) in
            if let x = x as? User {
                loggedInUserDetails.text = x.description
            }
        })                

        
        // A loading indicator - Indicates if API request is currently underway.
        RACObserve(target: self.viewModel, keyPath: "userLoadingInProgress").subscribeNext { (loading) in
            if let loading = loading as? Bool {
                if loading == true {
                    self.activityIndicatorView.startAnimating()
                } else {
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }

        let topLayoutGuide = self.topLayoutGuide
        let views: [String: Any] = ["topLayoutGuide": topLayoutGuide, "firstNameField": firstNameField, "lastNameField": lastNameField, "loginButton": loginButton, "loggedInUserDetails": loggedInUserDetails];
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:[topLayoutGuide]-20-[firstNameField(30)]-[lastNameField(30)]-40-[loginButton(30)]-[loggedInUserDetails(>=0)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-[firstNameField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-[lastNameField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-[loginButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-[loggedInUserDetails]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
    }

}

