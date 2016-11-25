//
//  UserPreferencesViewModelSpec.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 11/25/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
@testable import JKLoginMVVMDemoSwift

class UserPreferencesViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("Verifying the view model functionality when user preferences with flag load all data at once is activated") {
            var userPreferenceViewModel: UserPreferencesViewModel?
            beforeEach {
                let userPreference = UserPreference(switchValue: "1", sliderValue: "3.0", userName: "abc")
                userPreferenceViewModel = UserPreferencesViewModel(preference: userPreference)
            }
            
            describe("Verifying the initial values assigned to the view model") {
                it("All the initial parameters of view model should have valid values") {
                    expect(userPreferenceViewModel?.preference).toNot(beNil())
                    expect(userPreferenceViewModel?.loadingAllAtOnce).to(beTrue())
                }
            }
            
            describe("Verifying the model behavior when load all data at once flag is toggled on") {
                it("when load all data at once flag is toggled on, view model should load all data at once and initialize preferenceResponse object with it") {
                    expect(userPreferenceViewModel?.preferenceResponse).to(beNil())
                    userPreferenceViewModel?.loadData()
                    expect(userPreferenceViewModel?.preferenceResponse).toEventuallyNot(beNil(), timeout: 5.0)
                }
            }
        }
        
        describe("Verifying the view model functionality when user preferences with flag load data step by step is activated") {
            var userPreferenceViewModel: UserPreferencesViewModel?
            beforeEach {
                let userPreference = UserPreference(switchValue: "0", sliderValue: "3.0", userName: "abc")
                userPreferenceViewModel = UserPreferencesViewModel(preference: userPreference)
            }
            
            describe("Verifying the initial values assigned to the view model") {
                it("All the initial parameters of view model should have valid values") {
                    expect(userPreferenceViewModel?.preference).toNot(beNil())
                    expect(userPreferenceViewModel?.loadingAllAtOnce).to(beFalse())
                }
            }
            
            describe("verifying the model behavior when load all data at once flag is toggled off") {
                it("When load all data at once flag is toggled off, view model should load data in small increments and assign to individual properties step by step instead of loading it all at once and initializing preference model") {
                    expect(userPreferenceViewModel?.userName).to(beNil())
                    expect(userPreferenceViewModel?.rating).to(beNil())
                    expect(userPreferenceViewModel?.image).to(beNil())
                    userPreferenceViewModel?.loadData()
                    expect(userPreferenceViewModel?.userName).toEventuallyNot(beNil(), timeout: 5.0)
                    expect(userPreferenceViewModel?.rating).toEventuallyNot(beNil(), timeout: 5.0)
                    expect(userPreferenceViewModel?.image).toEventuallyNot(beNil(), timeout: 5.0)
                    
                }
            }
        }
    }
}

