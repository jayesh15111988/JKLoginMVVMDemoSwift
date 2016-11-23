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
    dynamic var image: UIImage?
    dynamic var rating: String?
    dynamic var userName: String?
    dynamic var loadingAllAtOnce: Bool
    
    init(preference: UserPreference) {
        self.preference = preference
        self.loadingAllAtOnce = preference.switchValue == "1"
    }
    
    func loadData() {
        if preference.switchValue == "0" || preference.switchValue == "" {
            self.loadStepByStepPreferencesData()
        } else {
            self.loadAllPreferencesData()
        }
    }
    
    func loadAllPreferencesData() {
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
    
    func loadStepByStepPreferencesData() {
        let imageSignal = UserAPI.sharedInstance.userImage(with: "https://upload.wikimedia.org/wikipedia/commons/0/0a/Wayfair_logo_with_tagline.png")
        let ratingSignal = UserAPI.sharedInstance.userRatingDetails()
        let userNameSignal = UserAPI.sharedInstance.userNameDetails()
        
        let stepSignal = userNameSignal.flattenMap { (userName) -> RACStream? in
            guard let userName = userName as? String else { return RACSignal.empty() }
            self.userName = userName
            return ratingSignal
        }.flattenMap { (rating) -> RACStream? in
            guard let rating = rating as? String else { return RACSignal.empty() }
            self.rating = rating
            return imageSignal
        }
        _ = stepSignal?.subscribeNext({ (image) in
            guard let image = image as? UIImage else { return }
            self.image = image
        })
        
    }
}
