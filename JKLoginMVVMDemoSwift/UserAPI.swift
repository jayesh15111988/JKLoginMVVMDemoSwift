//
//  UserAPI.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/10/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol UserAPIRequestProtocol {
    func user(with dictionary: [String: String]) -> RACSignal
    func preferences(with dictionary: [String: String]) -> RACSignal
    func userImage(with url: String) -> RACSignal
    func userNameDetails() -> RACSignal
    func userRatingDetails() -> RACSignal
}

class UserAPI: UserAPIRequestProtocol {
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
    
    func preferences(with dictionary: [String : String]) -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable? in
            let deadlineTime = DispatchTime.now() + 0.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                let preference = UserPreference(switchValue: dictionary["switchValue"]!, sliderValue: dictionary["sliderValue"]!, userName: dictionary["userName"]!)
                subscriber?.sendNext(preference)
                subscriber?.sendCompleted()
            }
            return nil
        })
    }
    
    func userImage(with url: String) -> RACSignal {
        let urlSignal = RACSignal.createSignal({ (subscriber) -> RACDisposable? in
            let deadlineTime = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                subscriber?.sendNext(NSURL(string: url))
                subscriber?.sendCompleted()
            }
            return nil
        }).deliver(on: RACScheduler.current())
        
        let mappedSignal = urlSignal?.map({ (url) -> Any? in
            if let url = url as? URL {
                do {
                    return try UIImage(data: Data(contentsOf: url))
                } catch {
                    print("Failed to get image data from server")
                }
            }
            return nil
        })
        return (mappedSignal?.deliver(on: RACScheduler.mainThread()))!
    }
    
    func userNameDetails() -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable? in
            let deadlineTime = DispatchTime.now() + 2.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                subscriber?.sendNext("This username is valid and maybe used for all the purposes. This username is valid and maybe used for all the purposes. This username is valid and maybe used for all the purposes")
                subscriber?.sendCompleted()
            }
            return nil
        })
    }
    
    func userRatingDetails() -> RACSignal {
        return RACSignal.createSignal({ (subscriber) -> RACDisposable? in
            let deadlineTime = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                subscriber?.sendNext("This user has lot of ratings so far and this is really good. All the time this person has done pretty good job. These ratings are important on our policy and maybe we can go back and do it again")
                subscriber?.sendCompleted()
            }
            return nil
        })
    }
}
