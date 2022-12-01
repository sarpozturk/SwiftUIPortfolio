//
//  HomeView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 30.11.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    static let tag: String? = "Home"
    
    var body: some View {
        NavigationView {
            Button("Add Data") {
                dataController.deleteAll()
                try? dataController.createSampleData()
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
