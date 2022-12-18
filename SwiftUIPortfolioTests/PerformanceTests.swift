//
//  PerformanceTests.swift
//  SwiftUIPortfolioTests
//
//  Created by Sarp  on 18.12.2022.
//

import XCTest
@testable import SwiftUIPortfolio

class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() throws {
        try dataController.createSampleData()

        let awards = Award.allAwards

        measure {
            _ = awards.filter(dataController.hasEarnedAward)
        }
    }
}
