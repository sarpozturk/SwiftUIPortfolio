//
//  HomeView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 30.11.2022.
//

import CoreData
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    static let tag: String? = "Home"
    
    @FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)], predicate: NSPredicate(format: "closed = false")) var projects: FetchedResults<Project>
    
    let items: FetchRequest<Item>
    
    var projectRows: [GridItem] {
        return [GridItem(.fixed(100))]
    }
    
    init() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let completedPredicate = NSPredicate(format: "completed = false")
        let openPredicate = NSPredicate(format: "project.closed = false")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [
            completedPredicate,
            openPredicate
        ])
        request.predicate = compoundPredicate
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.priority, ascending: false)
        ]
        request.fetchOffset = 10
        items = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: projectRows) {
                            ForEach(projects, content: ProjectSummaryView.init)
                        }
                        .padding([.horizontal, .top])
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    VStack(alignment: .leading) {
                        ItemListView(title: "Up Next", items: items.wrappedValue.prefix(3))
                        ItemListView(title: "Explore More", items: items.wrappedValue.dropFirst(3))
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
