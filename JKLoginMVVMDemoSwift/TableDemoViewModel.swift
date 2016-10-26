//
//  TableDemoViewModel.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/24/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import ReactiveCocoa

class TableDemoViewModel: NSObject {
    
    var addItemButtonActionCommand: RACCommand?
    dynamic var items: [String]
    dynamic var addItemButtonIndicator: Bool
    
    override init() {
        addItemButtonIndicator = false
        items = []
        super.init()
        addItemButtonActionCommand = RACCommand(signal: { (signal) -> RACSignal? in
            return RACSignal.return(true)
        })
        
        _ = addItemButtonActionCommand?.executionSignals.flatten(1).subscribeNext({ [weak self] (value) in
            if let value = value as? Bool {
                self?.addItemButtonIndicator = value
            }
        })
        
    }
    
    func addItem() {
        items.append("\(items.count)")
    }
}
