//
//  DevelopmentTests.swift
//  SwiftUIPortfolioTests
//
//  Created by Sarp  on 18.12.2022.
//

import CoreData
import XCTest
@testable import SwiftUIPortfolio

class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50)
    }

    func testDeleteAllClearsEverything() throws {
        // try dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "deleteAll() should leave 0 projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "deleteAll() should leave 0 items.")
    }
}
