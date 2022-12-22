//
//  EditProjectView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 2.12.2022.
//

import SwiftUI

struct EditProjectView: View {
    @StateObject var viewModel: ViewModel
    @State private var showDeleteConfirm: Bool = false

    let columns: [GridItem] = [GridItem(.adaptive(minimum: 44))]

    init(dataController: DataController, project: Project) {
        let viewModel = ViewModel(dataController: dataController, project: project)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Title", text: $viewModel.title)
                TextField("Detail of the project", text: $viewModel.detail)
            }

            Section(header: Text("Custom Project Color")) {
                LazyVGrid(columns: columns) {
                    ForEach(Project.colors, id: \.self, content: colorButton)
                }
            }

            // swiftlint:disable:next line_length
            Section(footer: Text("Closing a project moves it from the Open to Closed tab; deleting removes it entirely")) {
                Button(viewModel.project.closed ? "Reopen this project" : "Close this project") {
                    viewModel.project.closed.toggle()
                }

                Button("Delete this project") {
                    showDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
        }
        .navigationTitle("Edit Project")
        .onDisappear(perform: viewModel.save)
        .alert(isPresented: $showDeleteConfirm) {
            Alert(
                title: Text("Delete Project?"),
                primaryButton: .default(Text("OK"), action: viewModel.delete),
                secondaryButton: .cancel()
            )
        }
    }

    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(6)

            if viewModel.color == item {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            viewModel.color = item
            viewModel.update()
        }
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(dataController: DataController.preview, project: Project.example)
    }
}
