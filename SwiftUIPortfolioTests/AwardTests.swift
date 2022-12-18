//
//  AwardTests.swift
//  SwiftUIPortfolioTests
//
//  Created by Sarp  on 17.12.2022.
//

import CoreData
import XCTest
@testable import SwiftUIPortfolio

class AwardTests: BaseTestCase {
    let awards = Award.allAwards

    func testAwardIdMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name)
        }
    }

    func testNewUserHasNoAwards() {
        for award in awards {
            XCTAssertEqual(false, dataController.hasEarnedAward(award))
        }
    }

    func testEarnedItemAwards() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                _ = Item(context: managedObjectContext)
            }

            let awardsCount = awards.filter { award in
                award.criterion == "items" && dataController.hasEarnedAward(award)
            }

            XCTAssertEqual(awardsCount.count, count + 1)

            dataController.deleteAll()
        }
    }

    func testCompletedItemAwards() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
            }

            let awardsCount = awards.filter { award in
                award.criterion == "complete" && dataController.hasEarnedAward(award)
            }

            XCTAssertEqual(awardsCount.count, count + 1)

            dataController.deleteAll()
        }
    }
}
