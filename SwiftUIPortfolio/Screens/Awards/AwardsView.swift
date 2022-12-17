//
//  AwardsView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 3.12.2022.
//

import SwiftUI

struct AwardsView: View {
    static let tag: String? = "Awards"

    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example
    @State private var showingAwardAlert = false

    var columns: [GridItem] {
        return [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardAlert.toggle()
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                                .foregroundColor(color(for: award))
                        }
                    }
                }
            }
            .navigationTitle("Awards")
        }
        .alert(isPresented: $showingAwardAlert, content: getAwardAlert)
    }

    func color(for award: Award) -> Color {
        dataController.hasEarnedAward(award) ? Color(award.color) : .secondary.opacity(0.5)
    }

    func getAwardAlert() -> Alert {
        if dataController.hasEarnedAward(selectedAward) {
            return Alert(
                title: Text("Unlocked: \(selectedAward.name)"),
                message: Text(selectedAward.description),
                dismissButton: .default(Text("OK"))
            )
        } else {
            return Alert(
                title: Text("Locked: \(selectedAward.name)"),
                message: Text(selectedAward.description),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}
