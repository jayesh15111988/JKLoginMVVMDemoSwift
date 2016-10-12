//
//  RACObserve.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/10/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import ReactiveCocoa

// Source: https://github.com/ColinEberhardt/ReactiveSwiftFlickrSearch/tree/master/ReactiveSwiftFlickrSearch/Util

// replaces the RACObserve macro
func RACObserve(target: NSObject!, keyPath: String) -> RACSignal  {
    return target.rac_values(forKeyPath: keyPath, observer: target)
}
