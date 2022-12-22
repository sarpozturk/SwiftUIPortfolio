//
//  SwiftUIPortfolioUITests.swift
//  SwiftUIPortfolioUITests
//
//  Created by Sarp  on 22.12.2022.
//

import XCTest

final class SwiftUIPortfolioUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testAppHas4Tabs() throws {
        XCTAssertEqual(app.tabBars.buttons.count, 4, "There should be 4 tabs in the app.")
    }

    func testOpenTabAddsProject() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.tables.cells.count, 0)

        for tapCount in 1...5 {
            app.buttons["Add"].tap()
            XCTAssertEqual(app.tables.cells.count, tapCount, "There should be \(tapCount) rows(s) in the list.")
        }
    }

    func testEditingProjectUpdatesCorrectly() {
        app.buttons["Open"].tap()
        app.buttons["Add"].tap()
        app.buttons["COMPOSE"].tap()
        app.textFields["Title"].tap()
        app.keys["space"].tap()
        app.keys["more"].tap()
        app.keys["2"].tap()
        app.buttons["Return"].tap()
        app.buttons["Open Projects"].tap()
        XCTAssertTrue(app.buttons["New Project 2"].exists)
    }
}
