//
//  HomeView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 30.11.2022.
//

import CoreData
import CoreSpotlight
import SwiftUI

struct HomeView: View {
    static let tag: String? = "Home"
    @StateObject private var viewModel: ViewModel

    var projectRows: [GridItem] {
        return [GridItem(.fixed(100))]
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                if let item = viewModel.selectedItem {
                    NavigationLink(destination: EditItemView(item: item),
                                   tag: item,
                                   selection: $viewModel.selectedItem,
                                   label: EmptyView.init
                    )
                    .id(item)
                }

                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: projectRows) {
                            ForEach(viewModel.projects, content: ProjectSummaryView.init)
                        }
                        .padding([.horizontal, .top])
                        .fixedSize(horizontal: false, vertical: true)
                    }

                    VStack(alignment: .leading) {
                        ItemListView(title: "Up Next", items: viewModel.upNext)
                        ItemListView(title: "Explore More", items: viewModel.exploreMore)
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
            .toolbar {
                Button("Add Data") {
                    viewModel.addSampleData()
                }
            }
            .onContinueUserActivity(CSSearchableItemActionType, perform: loadSpotlightItem)
        }
    }

    func loadSpotlightItem(_ userActivity: NSUserActivity) {
        if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
            viewModel.selectItem(with: uniqueIdentifier)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: DataController.preview)
    }
}
