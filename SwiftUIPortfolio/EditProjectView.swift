//
//  EditProjectView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 2.12.2022.
//

import SwiftUI

struct EditProjectView: View {
    let project: Project
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 44))]
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var showDeleteConfirm: Bool = false
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Title", text: $title.onCreate(update))
                TextField("Detail of the project", text: $detail.onCreate(update))
            }
            
            Section(header: Text("Custom Project Color")) {
                LazyVGrid(columns: columns) {
                    ForEach(Project.colors, id: \.self, content: colorButton)
                }
            }
            
            Section(header: Text("Closing a project moves it from the Open to Closed tab; deleting removes it entirely")) {
                Button(project.closed ? "Reopen this project" : "Close this project") {
                    project.closed.toggle()
                }
                
                Button("Delete this project") {
                    showDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
        }
        .navigationTitle("Edit Project")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showDeleteConfirm) {
            Alert(title: Text("Delete Project?"), primaryButton: .default(Text("OK"), action: delete), secondaryButton: .cancel())
        }
    }
    
    func update() {
        project.title = title
        project.detail = detail
        project.color = color
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
    
    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(6)
            
            if color == item {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            color = item
            update()
        }
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
