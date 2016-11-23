//
//  UserPreferencesResultsController.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 11/20/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import UIKit

class UserPreferencesResultsController: UIViewController {
    
    let viewModel: UserPreferencesViewModel
    
    init(viewModel: UserPreferencesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Preferences"
        self.view.backgroundColor = .white
        
        let loadingStatusView = UIView()
        loadingStatusView.translatesAutoresizingMaskIntoConstraints = false
        loadingStatusView.backgroundColor = .white
        self.view.addSubview(loadingStatusView)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "sam.jpg")
        loadingStatusView.addSubview(imageView)
        
        let sliderViewStatus = UIView()
        sliderViewStatus.translatesAutoresizingMaskIntoConstraints = false
        sliderViewStatus.backgroundColor = .red
        self.view.addSubview(sliderViewStatus)
        
        let sliderViewLabel = UILabel()
        sliderViewLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderViewLabel.numberOfLines = 0
        sliderViewStatus.addSubview(sliderViewLabel)
        
        let userNameView = UIView()
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        userNameView.backgroundColor = .green
        self.view.addSubview(userNameView)
        
        let userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.numberOfLines = 0
        userNameView.addSubview(userNameLabel)
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
        activityIndicatorView.tintColor = .red
        activityIndicatorView.hidesWhenStopped = true
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        let views = ["loadingStatusView": loadingStatusView, "sliderViewStatus": sliderViewStatus, "userNameView": userNameView, "imageView": imageView, "sliderViewLabel": sliderViewLabel, "userNameLabel": userNameLabel]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[loadingStatusView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sliderViewStatus]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userNameView]|", options: [], metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sliderViewLabel]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userNameLabel]|", options: [], metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[sliderViewLabel]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[userNameLabel]|", options: [], metrics: nil, views: views))
        
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[loadingStatusView(<=300)][sliderViewStatus(>=0)][userNameView(>=0)]", options: [], metrics: nil, views: views))
        
        self.viewModel.loadPreferencesData()
        
        RACObserve(target: self.viewModel, keyPath: "preferenceResponse").subscribeNext({ (prefResponse) in
            if let prefResponse = prefResponse as? PreferencesResponse {
                activityIndicatorView.stopAnimating()
                imageView.image = prefResponse.image
                sliderViewLabel.text = prefResponse.userRating
                userNameLabel.text = prefResponse.userName
            }
        }, error: { error in
            activityIndicatorView.stopAnimating()
            print("Failed with error \(error?.localizedDescription)")
        })
    }
}
