//
//  Award.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 3.12.2022.
//

import Foundation

struct Award: Identifiable, Decodable {
    var id: String {
        name
    }

    let name: String
    let description: String
    let color: String
    let criterion: String
    let value: Int
    let image: String

    static let allAwards: [Award] = Bundle.main.decode([Award].self, from: "Awards.json")
    static let example = allAwards[0]
}
