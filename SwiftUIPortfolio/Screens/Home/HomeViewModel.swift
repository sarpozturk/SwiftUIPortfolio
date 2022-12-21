//
//  HomeViewModel.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 21.12.2022.
//

import CoreData
import Foundation

extension HomeView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        private let projectController: NSFetchedResultsController<Project>
        private let itemController: NSFetchedResultsController<Item>
        let dataController: DataController

        @Published var projects = [Project]()
        @Published var items = [Item]()

        var upNext: ArraySlice<Item> {
            items.prefix(3)
        }

        var exploreMore: ArraySlice<Item> {
            items.dropFirst(3)
        }

        init(dataController: DataController) {
            self.dataController = dataController

            let projectRequest: NSFetchRequest<Project> = Project.fetchRequest()
            projectRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Project.title, ascending: true)]
            projectRequest.predicate = NSPredicate(format: "closed = false")

            // Create a fetch request for first 10 high-priority items,
            // which are from open projects and not completed items.
            let itemRequest: NSFetchRequest<Item> = Item.fetchRequest()
            let completedPredicate = NSPredicate(format: "completed = false")
            let openPredicate = NSPredicate(format: "project.closed = false")
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [
                completedPredicate,
                openPredicate
            ])
            itemRequest.predicate = compoundPredicate
            itemRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \Item.priority, ascending: false)
            ]
            itemRequest.fetchLimit = 10

            projectController = NSFetchedResultsController(
                fetchRequest: projectRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            itemController = NSFetchedResultsController(
                fetchRequest: itemRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()
            projectController.delegate = self
            itemController.delegate = self

            do {
                try projectController.performFetch()
                projects = projectController.fetchedObjects ?? []

                try itemController.performFetch()
                items = itemController.fetchedObjects ?? []
            } catch {
                print("Failed to load object.")
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newItems = controller.fetchedObjects as? [Item] {
                items = newItems
            } else if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }

        }

        func addSampleData() {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }
    }
}
