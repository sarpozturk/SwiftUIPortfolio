//
//  EditProjectViewModel.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 22.12.2022.
//

import Foundation

extension EditProjectView {
    class ViewModel: ObservableObject {
        let project: Project
        let dataController: DataController

        @Published var title: String {
            didSet {
                update()
            }
        }
        @Published var detail: String {
            didSet {
                update()
            }
        }
        @Published var color: String

        init(dataController: DataController, project: Project) {
            self.dataController = dataController
            self.project = project
            title = project.projectTitle
            detail = project.projectDetail
            color = project.projectColor
        }

        func update() {
            project.title = title
            project.detail = detail
            project.color = color
        }

        func delete() {
            dataController.delete(project)
        }

        func save() {
            dataController.save()
        }
    }
}
