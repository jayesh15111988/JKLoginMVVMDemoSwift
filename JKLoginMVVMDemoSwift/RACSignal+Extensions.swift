//
//  RACSignal+Extensions.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/10/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import ReactiveCocoa

// Source: https://github.com/ColinEberhardt/ReactiveSwiftFlickrSearch/tree/master/ReactiveSwiftFlickrSearch/Util

// a collection of extension methods that allows for strongly typed closures
extension RACSignal {
    
    func subscribeNextAs<T>(nextClosure:@escaping (T) -> ()) -> () {
        self.subscribeNext {
            (next: Any!) -> () in
            let nextAsT = next! as! T
            nextClosure(nextAsT)
        }
    }
    
    func mapAs<T: AnyObject, U: AnyObject>(mapClosure:@escaping (T) -> U) -> RACSignal {
        return self.map {
            (next: Any!) -> Any! in
            let nextAsT = next as! T
            return mapClosure(nextAsT)
        }
    }
    
    func filterAs<T: AnyObject>(filterClosure:@escaping (T) -> Bool) -> RACSignal {
        return self.filter {
            (next: Any!) -> Bool in
            let nextAsT = next as! T
            return filterClosure(nextAsT)
        }
    }
    
    func doNextAs<T: AnyObject>(nextClosure:@escaping (T) -> ()) -> RACSignal {
        return self.doNext {
            (next: Any!) -> () in
            let nextAsT = next as! T
            nextClosure(nextAsT)
        }
    }
}
