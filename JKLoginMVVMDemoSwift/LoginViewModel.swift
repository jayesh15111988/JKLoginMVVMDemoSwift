//
//  LoginViewModel.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/10/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LoginViewModel: NSObject {
    // A loginButtonActionCommand associated with login button on login home page.
    var loginButtonCommandAction: RACCommand?
    // A flag to indicate if input is valid. Unless input is valid, login button is disabled and alpha is set to 0.5
    dynamic var loginInputValid: Bool = false
    // A flag to indicate that if API request is in progress. It will fire an UIActivityIndicator loader on the login page.
    dynamic var userLoadingInProgress: Bool
    
    // Properties associated with login user
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    
    // Logged in user is set once request is complete and we create a JKUser object with data received from the server
    dynamic var loggedInUser: User?
    
    override init() {
        
        self.userLoadingInProgress = false
        
        super.init()
        
        self.loginButtonCommandAction = RACCommand(signal: { [weak self] (input) -> RACSignal? in
            return UserAPI.sharedInstance.user(with: ["first_name": (self?.firstName)!, "last_name": (self?.lastName)!])
        })
        
        _ = self.loginButtonCommandAction?.executionSignals.flatten()?.subscribeNext({ [weak self] (x) in
            if let user = x as? User {
                self?.loggedInUser = user
            }
        })
        
        _ = self.loginButtonCommandAction?.executing.subscribeNext { (x) in
            if let x = x as? Bool {
                self.userLoadingInProgress = x
                self.loginInputValid = !x
            }
        }
        
        _ = self.loginButtonCommandAction?.errors.subscribeNext { (x) in
            if let x = x as? NSError {
                print("Error Occurred while loggin user is \(x.localizedDescription)")
            }
        }
        
        let firstNameSignal = RACObserve(target: self, keyPath: "firstName")
        let lastNameSignal = RACObserve(target: self, keyPath: "lastName")
        
        
        let inputValidationSignal = RACSignal.combineLatest(NSArray(array: [firstNameSignal, lastNameSignal])).map { (value) -> Bool? in
            if let inputValue = value as? RACTuple, let firstName = inputValue.first as? String, let lastName = inputValue.second as? String {
                return firstName.characters.count > 0 && lastName.characters.count > 0
            }
            return false
        }
        _ = inputValidationSignal?.subscribeNext({ (value) in
            if let value = value as? Bool {
                self.loginInputValid = value
            }
        })
    }

}
