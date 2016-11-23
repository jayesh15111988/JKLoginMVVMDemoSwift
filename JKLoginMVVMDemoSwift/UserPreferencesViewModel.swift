//
//  UserPreferencesViewModel.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 11/20/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import ReactiveCocoa

class UserPreferencesViewModel: NSObject {
    
    let preference: UserPreference
    dynamic var preferenceResponse: PreferencesResponse?
    
    init(preference: UserPreference) {
        self.preference = preference        
    }
    
    func loadPreferencesData() {
        let combinedSignal = RACSignal.combineLatest(NSArray(array: [UserAPI.sharedInstance.userImage(with: "https://upload.wikimedia.org/wikipedia/commons/0/0a/Wayfair_logo_with_tagline.png"), UserAPI.sharedInstance.userRatingDetails(), UserAPI.sharedInstance.userNameDetails()]))
        _ = combinedSignal?.subscribeNext({ (tuple) in
            if let tuple = tuple as? RACTuple {
                guard let image = tuple.first as? UIImage, let rating = tuple.second as? String, let userName = tuple.third as? String else {
                    return
                }
                self.preferenceResponse = PreferencesResponse(image: image, userRating: rating, userName: userName)
            }
        })
        
    }
}
