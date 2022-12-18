//
//  Item-CoreDataHelper.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 1.12.2022.
//

import Foundation

extension Item {
    enum SortOrder {
        case optimized, creationDate, title
    }

    var itemTitle: String {
        title ?? NSLocalizedString("New Item", comment: "Create a new item")
    }

    var itemDetail: String {
        detail ?? ""
    }

    var itemCreationDate: Date {
        creationDate ?? Date()
    }

    static var example: Item {
        let dataController = DataController.preview
        let context = dataController.container.viewContext

        let item = Item(context: context)
        item.title = "Example Item"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()
        return item
    }
}
