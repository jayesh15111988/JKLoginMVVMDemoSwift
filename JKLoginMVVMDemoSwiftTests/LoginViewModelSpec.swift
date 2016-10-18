//
//  LoginViewModelSpec.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import JKLoginMVVMDemoSwift

class LoginViewModelSpec: QuickSpec {
    override func spec() {
        describe("Verifying the Login View Model") { 
            it("Login view model when initialized should iitialize all its properties to initial value", closure: { 
                let loginViewModel = LoginViewModel()
                expect(loginViewModel.userLoadingInProgress).to(beFalse())
                expect(loginViewModel.firstName).to(beEmpty())
                expect(loginViewModel.lastName).to(beEmpty())
                expect(loginViewModel.loginInputValid).to(beFalse())
            })
            
            it("All the signals should have non-nil values on view model initialization", closure: { 
                let loginViewModel = LoginViewModel()
                expect(loginViewModel.loginButtonCommandAction).notTo(beNil())
            })
            
            it("View model should emit the valid input signal when model is presented with valid input values", closure: { 
                let loginViewModel = LoginViewModel()
                expect(loginViewModel.loginInputValid).to(beFalse())
                loginViewModel.firstName = "Jayesh"
                loginViewModel.lastName = "Kawli"
                expect(loginViewModel.loginInputValid).to(beTrue())
            })
        }
    }
}
