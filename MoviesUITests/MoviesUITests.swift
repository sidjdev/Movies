//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Sidharth J Dev on 17/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import XCTest

class clicked_list_cell: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

    }
    
    func test_is_transitioning_to_details() {
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables.matching(identifier: "movieTable")
        let cell = tableView.cells.element(matching: .cell, identifier: "cell-0")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            cell.tap()
        }
    }

}
