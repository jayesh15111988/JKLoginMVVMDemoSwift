//
//  UserAPI.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/10/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import ReactiveCocoa

class UserAPI: NSObject {
    // We create a singleton shareAPIManager to handle all out API interactions.
    static let sharedInstance = UserAPI()
    
    // Once we get userDictionary, we make (dummy) API call and assume API gives us all the information plus auth token back after login.
    func user(with dictionary: [String: String]) -> RACSignal {
    
        return RACSignal.createSignal({ (subscriber) -> RACDisposable? in
            let deadlineTime = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                if let firstName = dictionary["first_name"], let lastName = dictionary["last_name"] {
                    let userObject = User(dictionary: ["first_name": firstName, "last_name": lastName, "auth_token": "123adasdsadasdasdasdd"])
                    subscriber?.sendNext(userObject)
                }
                subscriber?.sendCompleted()
            }
            return nil
        })
    }
}
