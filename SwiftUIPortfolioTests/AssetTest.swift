//
//  AssetTest.swift
//  SwiftUIPortfolioTests
//
//  Created by Sarp  on 17.12.2022.
//

import XCTest
@testable import SwiftUIPortfolio

class AssetTest: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color \(color) from Color asset.")
        }
    }

    func testJSONLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load data from Awards.json")
    }
}
