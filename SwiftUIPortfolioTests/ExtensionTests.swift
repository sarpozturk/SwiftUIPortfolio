//
//  ExtensionTests.swift
//  SwiftUIPortfolioTests
//
//  Created by Sarp  on 18.12.2022.
//

import SwiftUI
import XCTest
@testable import SwiftUIPortfolio

class ExtensionTests: BaseTestCase {
    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty)
    }

    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let mockString = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(mockString, "This is a mock string data")
    }

    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let mockDictionary = bundle.decode([String: Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(mockDictionary.count, 3)
    }

    func testBindingOnChange() {
        // Given
        var onChangeFunctionRun = false

        func functionToCall() {
            onChangeFunctionRun = true
        }

        var storedData = ""

        let binding = Binding(
            get: { storedData },
            set: { storedData = $0 }
        )

        let changedBinding = binding.onCreate(functionToCall)
        // When
        changedBinding.wrappedValue = "changed"

        // Then
        XCTAssertTrue(onChangeFunctionRun,
                      "The onChange() function should be called after change is being made on binding.")
    }
}
