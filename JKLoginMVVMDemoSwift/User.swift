//
//  User.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/10/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation

class User: NSObject {
    
    var firstName: String
    var lastName : String
    var authToken: String
    
    override var debugDescription: String {
        return "\(firstName)\n\(lastName)\n\(authToken)\n"
    }
    
    init(dictionary: [String: String]) {
        self.firstName = ""
        self.lastName = ""
        self.authToken = ""
        if let firstName = dictionary["first_name"] {
            self.firstName = firstName
        }
        
        if let lastName = dictionary["last_name"] {
            self.lastName = lastName
        }
        
        if let authToken = dictionary["auth_token"] {
            self.authToken = authToken
        }
        super.init()
    }
}
