//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Sidharth J Dev on 17/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {

    func testStringComparisonAlgorithm() {
        let string = "Le Wale"
        let phrase = "Dil Wale Dulhaniya Le Jayege"
        XCTAssertTrue(MovieListVM().isString(string, in: phrase))
        let letter = "J"
        XCTAssertTrue(MovieListVM().isString(letter, in: phrase))
    }
    

}
