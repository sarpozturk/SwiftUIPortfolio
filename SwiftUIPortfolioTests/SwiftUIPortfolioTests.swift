//
//  SwiftUIPortfolioTests.swift
//  SwiftUIPortfolioTests
//
//  Created by Sarp  on 17.12.2022.
//

import CoreData
import XCTest
@testable import SwiftUIPortfolio

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
