//
//  UserInteractionViewModel.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 11/20/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import ReactiveCocoa

class UserInteractionViewModel: NSObject {
    
    var doneButtonCommandAction: RACCommand?
    dynamic var userName: String
    dynamic var sliderValue: Double
    dynamic var doneButtonPressedIndicator: Bool = false
    dynamic var loadAllAtOnce: Bool
    dynamic var preference: UserPreference?
    var inputDictionary: [String: String]
    
    override init() {
        userName = ""
        self.inputDictionary = [:]
        sliderValue = 0
        loadAllAtOnce = false
        super.init()
        
        self.doneButtonCommandAction = RACCommand(signal: { [weak self] (input) -> RACSignal? in
            return UserAPI.sharedInstance.preferences(with: (self?.inputDictionary)!)
        })
        
        _ = self.doneButtonCommandAction?.executionSignals.flatten()?.subscribeNext({ [weak self] (x) in
            if let pre = x as? UserPreference {
                self?.preference = pre
            }
        })
        
        _ = self.doneButtonCommandAction?.errors.subscribeNext { (x) in
            if let x = x as? NSError {
                print("Error Occurred while saving user preferences \(x.localizedDescription)")
            }
        }
        
        let userNameSignal = RACObserve(target: self, keyPath: "userName")
        userNameSignal.subscribeNext { [weak self] (userName) in
            if let userName = userName as? String {
                self?.inputDictionary["userName"] = userName
            }
        }
        
        RACObserve(target: self, keyPath: "sliderValue").subscribeNext { [weak self] (sliderValue) in
            if let sliderValue = sliderValue as? Double {
                self?.inputDictionary["sliderValue"] = "\(sliderValue)"
            }
        }
        
        RACObserve(target: self, keyPath: "loadAllAtOnce").subscribeNext { [weak self] (switchValue) in
            if let switchValue = switchValue as? Bool {
                self?.inputDictionary["switchValue"] = switchValue ? "1" : "0"
            }
        }
        
        
    }
}
