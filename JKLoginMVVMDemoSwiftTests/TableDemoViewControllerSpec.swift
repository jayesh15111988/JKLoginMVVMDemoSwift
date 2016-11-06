//
//  TableDemoViewControllerSpec.swift
//  JKLoginMVVMDemoSwift
//
//  Created by Jayesh Kawli on 10/29/16.
//  Copyright © 2016 Jayesh Kawli. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
@testable import JKLoginMVVMDemoSwift

class TableDemoViewControllerSpec: QuickSpec {
    
    override func spec() {
        var tableDemoViewController: TableDemoViewController?
        
        beforeEach {
            let tableDemoViewModel = TableDemoViewModel()
            tableDemoViewModel.items = ["One", "Two", "Three"]
            tableDemoViewController = TableDemoViewController(viewModel: tableDemoViewModel)
        }
        
        describe("Verifying the tableView datasource and delegate methods") {
            it("Tableview datasource and delegate methods when called should return correct number of elements or cell with expected label", closure: {
                _ = tableDemoViewController?.view
                
                let numberOfItems = tableDemoViewController?.tableView.numberOfRows(inSection: 0)
                expect(numberOfItems).to(equal(3))
                
                let cell1 = tableDemoViewController?.tableView.dataSource?.tableView((tableDemoViewController?.tableView)!, cellForRowAt: IndexPath(row: 1, section: 0))
                expect(cell1?.textLabel?.text).to(equal("Two"))
                
                let cell2 = tableDemoViewController?.tableView.dataSource?.tableView((tableDemoViewController?.tableView)!, cellForRowAt: IndexPath(row: 2, section: 0))
                expect(cell2?.textLabel?.text).to(equal("Three"))                
            })
        }
        
        describe("Verifying the table view delete item delegate method") {
            it("when the table view cell is swipe to delete, it should remove item at a given index from items collection", closure: {
                tableDemoViewController?.tableView((tableDemoViewController?.tableView)!, commit: .delete, forRowAt: IndexPath(item: 0, section: 0))
                expect(tableDemoViewController?.viewModel.items.count).to(equal(2))
                expect(tableDemoViewController?.viewModel.items).to(equal(["Two", "Three"]))
                tableDemoViewController?.tableView((tableDemoViewController?.tableView)!, commit: .delete, forRowAt: IndexPath(item: 1, section: 0))
                expect(tableDemoViewController?.viewModel.items.count).to(equal(1))
                expect(tableDemoViewController?.viewModel.items).to(equal(["Two"]))
                
            })
        }        
    
    }
}
