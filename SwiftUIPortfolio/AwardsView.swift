//
//  AwardsView.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 3.12.2022.
//

import SwiftUI

struct AwardsView: View {
    static let tag: String? = "Awards"
    
    var columns: [GridItem] {
        return [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Image(systemName: award.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                }
            }
            .navigationTitle("Awards")
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}
