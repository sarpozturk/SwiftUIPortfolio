//
//  ProjectsView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 30.11.2022.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    let projects: FetchRequest<Project>
    let showClosedProjects: Bool
    
    @EnvironmentObject private var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showSortActionSheet: Bool = false
    @State private var sortOder: Item.SortOrder = .optimized
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        self.projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed=%d", showClosedProjects))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(items(for: project)) { item in
                            ItemRowView(project: project, item: item)
                        }
                        .onDelete { offSets in
                            let allItems = items(for: project)
                            for offSet in offSets {
                                let item = allItems[offSet]
                                dataController.delete(item)
                            }
                            dataController.save()
                        }
                        
                        if showClosedProjects == false {
                            Button {
                                let item = Item(context: managedObjectContext)
                                item.project = project
                                item.creationDate = Date()
                                dataController.save()
                            } label: {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSortActionSheet.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if showClosedProjects == false {
                        Button {
                            let project = Project(context: managedObjectContext)
                            project.closed = false
                            project.creationDate = Date()
                            dataController.save()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .actionSheet(isPresented: $showSortActionSheet) {
                ActionSheet(title: Text("Sort Items"), message: nil, buttons: [
                    .default(Text("Optimized")) {
                        sortOder = .optimized
                    },
                    .default(Text("Creation Date")) {
                        sortOder = .creationDate
                    },
                    .default(Text("Title")) {
                        sortOder = .title
                    }
                ])
            }
        }
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
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController(inMemory: true)
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
