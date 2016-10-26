//
//  LandingViewModelSpec.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/24/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import JKLoginMVVMDemoSwift

class LandingViewModelSpec: QuickSpec {
    override func spec() {
        describe("Verifying the actions when buttons are pressed on the landing view controller") {
            
            var landingViewModel: LandingViewModel?
            
            beforeEach {
                landingViewModel = LandingViewModel()
            }
            
            it("Upon initialization all parameters of landing view model should have valid initial values", closure: { 
                expect(landingViewModel?.loginDemoButtonCommand).toNot(beNil())
                expect(landingViewModel?.tableViewDemoButtonCommand).toNot(beNil())
            })
            
            it("When login view model demo button is pressed, it should activate login button press indicator flag") {
                expect(landingViewModel?.loginDemoButtonPressedIndicator).to(beFalse())
                _ = landingViewModel?.loginDemoButtonCommand?.execute(nil)
                expect(landingViewModel?.loginDemoButtonPressedIndicator).to(beTrue())
            }
            
            it("When tableView view model demo button is pressed, it should activate tableView button press indicator flag") {
                expect(landingViewModel?.tableViewDemoButtonPressedIndicator).to(beFalse())
                _ = landingViewModel?.tableViewDemoButtonCommand?.execute(nil)
                expect(landingViewModel?.tableViewDemoButtonPressedIndicator).to(beTrue())
            }
        }
    }
}
