//
//  Binding-OnCreate.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 1.12.2022.
//

import Foundation
import SwiftUI

extension Binding {
    func onCreate(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: {
                self.wrappedValue
            },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            })
    }
}
