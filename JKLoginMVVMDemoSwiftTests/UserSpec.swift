//
//  UserSpec.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import JKLoginMVVMDemoSwift

class UserSpec: QuickSpec {
    override func spec() {
        describe("Verifying the behavior of User Model") { 
            it("The user object initialized with valid non-empty dictionary should have corresponding properties associated with it", closure: {
                let user = User(dictionary: ["first_name": "Jayesh", "last_name": "Kawli", "auth_token": "11111"])
                expect(user.firstName).to(equal("Jayesh"))
                expect(user.lastName).to(equal("Kawli"))
                expect(user.authToken).to(equal("11111"))
            })
            
            it("The user object initialized with empty dictionary should have empty properties associated with it", closure: { 
                let user = User(dictionary: [:])
                expect(user.firstName).to(beEmpty())
                expect(user.firstName).to(beEmpty())
                expect(user.firstName).to(beEmpty())
            })
        }
    }
}
