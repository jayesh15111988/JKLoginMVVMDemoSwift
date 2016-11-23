//
//  UserPreference.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 11/20/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation

class UserPreference: NSObject {
    var switchValue: String
    var sliderValue: String
    var userName: String
    
    init(switchValue: String, sliderValue: String, userName: String) {
        self.switchValue = switchValue
        self.sliderValue = sliderValue
        self.userName = userName
        super.init()
    }
}
