//
//  PreferencesResponse.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 11/23/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import UIKit

class PreferencesResponse: NSObject {
    let image: UIImage
    let userRating: String
    let userName: String
    init(image: UIImage, userRating: String, userName: String) {
        self.image = image
        self.userRating = userRating
        self.userName = userName
        super.init()
    }
}
