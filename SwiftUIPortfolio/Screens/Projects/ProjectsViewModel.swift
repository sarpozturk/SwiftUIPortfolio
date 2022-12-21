//
//  ProjectsViewModel.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 20.12.2022.
//

import CoreData
import Foundation

extension ProjectsView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        let dataController: DataController

        // MARK: Not using NSFetchRequest here, because NSFetchRequest fetches only once
        private let projectController: NSFetchedResultsController<Project>
        @Published var projects = [Project]()

        var sortOder: Item.SortOrder = .optimized
        let showClosedProjects: Bool

        init(dataController: DataController, showClosedProjects: Bool) {
            self.dataController = dataController
            self.showClosedProjects = showClosedProjects

            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
            request.predicate = NSPredicate(format: "closed = %d", showClosedProjects)

            projectController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()
            projectController.delegate = self

            do {
                try projectController.performFetch()
                projects = projectController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch the projects.")
            }
        }

        func delete(_ offSets: IndexSet, for project: Project) {
            let allItems = items(for: project)
            for offSet in offSets {
                let item = allItems[offSet]
                dataController.delete(item)
            }
            dataController.save()
        }

        func addItem(to project: Project) {
            let item = Item(context: dataController.container.viewContext)
            item.project = project
            item.creationDate = Date()
            dataController.save()
        }

        func addProject() {
            let project = Project(context: dataController.container.viewContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }

        func items(for project: Project) -> [Item] {
            switch sortOder {
            case .optimized:
                return project.projectItemsDefaultSorted
            case .creationDate:
                return project.projectItems.sorted { item1, item2 in
                    item1.itemCreationDate < item2.itemCreationDate
                }
            case .title:
                return project.projectItems.sorted { item1, item2 in
                    item1.itemTitle < item2.itemTitle
                }
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
    }
}
