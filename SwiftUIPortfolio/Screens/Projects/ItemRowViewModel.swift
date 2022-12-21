//
//  ItemRowViewModel.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 21.12.2022.
//

import Foundation

extension ItemRowView {
    class ViewModel: ObservableObject {
        let project: Project
        let item: Item

        var title: String {
            item.itemTitle
        }

        var iconName: String {
            if item.completed == true {
                return "checkmark.circle"
            } else if item.priority == 3 {
                return "exclamationmark.triangle"
            } else {
                return "checkmark.circle"
            }
        }

        var color: String? {
            if item.completed == true {
                return project.projectColor
            } else if item.priority == 3 {
                return project.projectColor
            } else {
                return nil
            }
        }

        init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }
    }
}
