//
//  ItemRowView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 1.12.2022.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var item: Item
    @StateObject private var viewModel: ViewModel

    init(project: Project, item: Item) {
        let viewModel = ViewModel(project: project, item: item)
        _viewModel = StateObject(wrappedValue: viewModel)
        self.item = item
    }

    var body: some View {
        NavigationLink {
            EditItemView(item: item)
        } label: {
            Label {
                Text("\(viewModel.title)")
            } icon: {
                Image(systemName: viewModel.iconName)
                    .foregroundColor(viewModel.color.map { Color($0) } ?? .clear)
            }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
