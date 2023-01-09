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
        @Published var remindMe: Bool
        @Published var reminderTime: Date
        @Published var showingNotificationsError: Bool = false

        init(dataController: DataController, project: Project) {
            self.dataController = dataController
            self.project = project
            title = project.projectTitle
            detail = project.projectDetail
            color = project.projectColor
            if let reminder = project.reminderTime {
                reminderTime = reminder
                remindMe = true
            } else {
                reminderTime = Date()
                remindMe = false
            }
        }

        func update() {
            project.title = title
            project.detail = detail
            project.color = color

            if remindMe {
                project.reminderTime = reminderTime

                dataController.addReminders(for: project) { [weak self] success in
                    guard let self = self else { return }
                    if success == false {
                        self.project.reminderTime = nil
                        self.remindMe = false
                        self.showingNotificationsError = true
                    }
                }
            } else {
                project.reminderTime = nil
                dataController.removeReminders(for: project)
            }
        }

        func delete() {
            dataController.delete(project)
        }

        func save() {
            dataController.save()
        }
    }
}
