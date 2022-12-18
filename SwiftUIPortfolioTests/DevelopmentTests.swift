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
        try dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0)
    }

    func testExampleProjectIsClosed() {
        let project = Project.example
        XCTAssertTrue(project.closed, "The example project should be closed.")
    }

    func testExampleItemIsHighPriority() {
        let item = Item.example
        XCTAssertEqual(item.priority, 3, "The example item should be high priority.")
    }
}
