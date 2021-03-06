//
//  TableDemoViewModelSpec.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/24/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import JKLoginMVVMDemoSwift

class TableDemoViewModelSpec: QuickSpec {
    override func spec() {
        
        var tableDemoViewController: TableDemoViewController?
        var tableDemoViewModel: TableDemoViewModel?
        beforeEach {
            tableDemoViewModel = TableDemoViewModel()
            tableDemoViewController = TableDemoViewController(viewModel: tableDemoViewModel!)
            _ = tableDemoViewController?.view
        }
        
        describe("Verifying the initial parameters of tableDemo view model upon initialization") { 
            it("On initialization all variables of view model should hold valid initial values", closure: { 
                expect(tableDemoViewModel?.addItemButtonIndicator).to(beFalse())
                expect(tableDemoViewModel?.items).toNot(beNil())
                expect(tableDemoViewModel?.items.count).to(equal(0))
                expect(tableDemoViewModel?.addItemButtonActionCommand).toNot(beNil())
            })
        }
        
        describe("Verifying the action of adding items to array when add button is pressed") { 
            it("When add item button is pressed, it should add items one at a time in the array", closure: {
                expect(tableDemoViewModel?.items.count).to(equal(0))
                _ = try? tableDemoViewModel?.addItemButtonActionCommand?.execute(nil).asynchronouslyWaitUntilCompleted()
                expect(tableDemoViewModel?.items.count).to(equal(1))
                _ = try?tableDemoViewModel?.addItemButtonActionCommand?.execute(nil).asynchronouslyWaitUntilCompleted()
                expect(tableDemoViewModel?.items.count).to(equal(2))
            })
        }
        
        describe("Verifying the action of removing items from array when a table view row is swiped to delete") {
            it("When table view row is swiped to delete, it should remove an item from array at a given index", closure: {
                tableDemoViewModel?.items = ["1", "2", "3"]
                tableDemoViewModel?.removeItem(at: 0)
                expect(tableDemoViewModel?.items.count).to(equal(2))
                expect(tableDemoViewModel?.items).to(equal(["2", "3"]))
                tableDemoViewModel?.removeItem(at: 1)
                expect(tableDemoViewModel?.items.count).to(equal(1))
                expect(tableDemoViewModel?.items).to(equal(["2"]))
            })
        }
    }
    
}
