//
//  ItemRowView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 1.12.2022.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var project: Project
    @ObservedObject var item: Item
    
    var icon: some View {
        if item.completed == true {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(Color(project.projectColor))
        }
        else if item.priority == 3 {
            return Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color(project.projectColor))
        }
        else {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(.clear)
        }
    }
    
    var body: some View {
        NavigationLink {
            EditItemView(item: item)
        } label: {
            Label {
                Text("\(item.itemTitle)")
            } icon: {
                icon
            }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
