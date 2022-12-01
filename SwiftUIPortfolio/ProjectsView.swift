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
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        self.projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed=%d", showClosedProjects))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(project.projectItems) { item in
                            ItemRowView(item: item)
                        }
                        .onDelete { offSets in
                            for offSet in offSets {
                                let item = project.projectItems[offSet]
                                dataController.delete(item)
                            }
                            dataController.save()
                        }
                    }
                }
            }
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .listStyle(.insetGrouped)
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
