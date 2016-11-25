//
//  UserInteractionViewModelSpec.swift
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

class UserInteractionViewModelSpec: QuickSpec {
    
    override func spec() {
        var userInteractionViewModel: UserInteractionViewModel?
        
        beforeEach {
            userInteractionViewModel = UserInteractionViewModel()
            userInteractionViewModel?.inputDictionary = [:]
        }
        
        describe("Verifying the initial state of user interaction view model") {
            it("User interaction model should have initial values of all variables just after initialization") {
                expect(userInteractionViewModel?.userName.characters.count).to(equal(0))
                expect(userInteractionViewModel?.inputDictionary.count).to(equal(0))
                expect(userInteractionViewModel?.sliderValue).to(equal(0))
                expect(userInteractionViewModel?.loadAllAtOnce).to(beFalse())
            }
        }
        
        describe("Verifying that user model stores all input values as they are entered by the user") {
            it("when user enters the first name, view model should store its value in dictionary under key userName") {
                userInteractionViewModel?.userName = "abc"
                expect(userInteractionViewModel?.inputDictionary.count).to(equal(1))
                expect(userInteractionViewModel?.inputDictionary["userName"]).to(equal("abc"))
            }
            
            it("when user changes the slider value, view model should store its value in dictionary under key sliderValue") {
                userInteractionViewModel?.sliderValue = 3.0
                expect(userInteractionViewModel?.inputDictionary.count).to(equal(1))
                expect(userInteractionViewModel?.inputDictionary["sliderValue"]).to(equal("3.0"))
            }
            
            it("when user toggles the switch, view model should store its value in dictionary under key switchValue") {
                userInteractionViewModel?.loadAllAtOnce = true
                expect(userInteractionViewModel?.inputDictionary.count).to(equal(1))
                expect(userInteractionViewModel?.inputDictionary["switchValue"]).to(equal("1"))
            }
        }
        
        describe("Verifying the behavior when user presses done button") {
            it("After user presses done button, mode should populate preference object with input values given by user in previous step") {
                userInteractionViewModel?.userName = "abc"
                userInteractionViewModel?.sliderValue = 3.0
                userInteractionViewModel?.loadAllAtOnce = true
                _ = try? userInteractionViewModel?.doneButtonCommandAction?.execute(nil).asynchronouslyWaitUntilCompleted()
                expect(userInteractionViewModel?.preference).toEventuallyNot(beNil(), timeout: 5.0)
                expect(userInteractionViewModel?.preference?.switchValue).toEventually(equal("1"), timeout: 5.0)
                expect(userInteractionViewModel?.preference?.sliderValue).toEventually(equal("3.0"), timeout: 5.0)
                expect(userInteractionViewModel?.preference?.userName).toEventually(equal("abc"), timeout: 5.0)
            }
        }
    }
}
