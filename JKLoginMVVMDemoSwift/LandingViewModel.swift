//
//  LandingViewModel.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/24/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LandingViewModel: NSObject {
    
    var loginDemoButtonCommand: RACCommand?
    var tableViewDemoButtonCommand: RACCommand?
    var userInteractionButtonCommand: RACCommand?
    
    dynamic var loginDemoButtonPressedIndicator: Bool
    dynamic var tableViewDemoButtonPressedIndicator: Bool
    dynamic var userInteractionDemoButtonPressedIndicator: Bool
    
    override init() {
        
        loginDemoButtonPressedIndicator = false
        tableViewDemoButtonPressedIndicator = false
        userInteractionDemoButtonPressedIndicator = false
        
        super.init()
        
        loginDemoButtonCommand = RACCommand(signal: { [weak self] (signal) -> RACSignal? in
            self?.loginDemoButtonPressedIndicator = true
            return RACSignal.empty()
        })
        
        tableViewDemoButtonCommand = RACCommand(signal: { [weak self] (signal) -> RACSignal? in
            self?.tableViewDemoButtonPressedIndicator = true
            return RACSignal.empty()
        })
        
        userInteractionButtonCommand = RACCommand(signal: { [weak self] (signal) -> RACSignal? in
            self?.userInteractionDemoButtonPressedIndicator = true
            return RACSignal.empty()
        })
    }
}
