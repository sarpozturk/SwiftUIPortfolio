//
//  ProjectHeaderView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 2.12.2022.
//

import SwiftUI

struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    @EnvironmentObject var dataController: DataController

    init(project: Project) {
        self.project = project
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(project.projectTitle)")
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }

            Spacer()

            NavigationLink(destination: EditProjectView(dataController: dataController, project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
        .padding(.bottom, 10)
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
            .environmentObject(DataController.preview)
    }
}
