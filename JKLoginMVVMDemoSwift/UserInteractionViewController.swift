//
//  UserInteractionViewController.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 11/20/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import UIKit

class UserInteractionViewController: UIViewController {
    let viewModel: UserInteractionViewModel
    init(viewModel: UserInteractionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "User Interaction Demo"
        
        let userLoadingPrefLabel = UILabel()
        userLoadingPrefLabel.translatesAutoresizingMaskIntoConstraints = false
        userLoadingPrefLabel.numberOfLines = 0
        userLoadingPrefLabel.text = "Load all at once?"
        userLoadingPrefLabel.textAlignment = .center
        self.view.addSubview(userLoadingPrefLabel)
        
        let userSwitch = UISwitch()
        userSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(userSwitch)
        
        let userSlider = UISlider()
        userSlider.translatesAutoresizingMaskIntoConstraints = false
        userSlider.minimumValue = 0.0
        userSlider.maximumValue = 10.0
        self.view.addSubview(userSlider)
        
        let userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.borderStyle = .line
        userNameTextField.placeholder = "Enter your name"
        self.view.addSubview(userNameTextField)
        
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitleColor(UIColor.black, for: .normal)
        doneButton.layer.borderColor = UIColor.lightGray.cgColor;
        doneButton.layer.borderWidth = 1.0;
        doneButton.setTitle("Done", for: .normal)
        doneButton.rac_command = self.viewModel.doneButtonCommandAction;
        self.view.addSubview(doneButton)
        
        userNameTextField.rac_textSignal().subscribeNext({ (name) in
            if let name = name as? String {
                self.viewModel.userName = name
            }
        })
        
        userSlider.rac_newValueChannel(withNilValue: 0).subscribeNext { (value) in
            if let value = value as? Double {
                self.viewModel.sliderValue = value
            }
        }
        
        userSwitch.rac_newOnChannel().subscribeNext { (value) in
            if let value = value as? Bool {
                self.viewModel.loadAllAtOnce = value
            }
        }
        
        RACObserve(target: self.viewModel, keyPath: "preference").ignore(nil).subscribeNext { (preferences) in
            if let preferences = preferences as? UserPreference {
                let preferenceViewController = UserPreferencesResultsController(viewModel: UserPreferencesViewModel(preference: preferences))
                    self.navigationController?.pushViewController(preferenceViewController, animated: true)
            }
        }
        
        let topLayoutGuide = self.topLayoutGuide        
        let views: [String: AnyObject] = ["userSwitch": userSwitch, "userSlider": userSlider, "userNameTextField": userNameTextField, "topLayoutGuide": topLayoutGuide, "doneButton": doneButton, "userLoadingPrefLabel": userLoadingPrefLabel]
        
        self.view.addConstraint(NSLayoutConstraint(item: userSwitch, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[userSlider]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[userNameTextField]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[doneButton]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[userLoadingPrefLabel]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-20-[userLoadingPrefLabel]-20-[userSwitch(>=0)]-20-[userSlider(>=0)]-20-[userNameTextField(21)]-40-[doneButton(34)]", options: [], metrics: nil, views: views))
    }
}
