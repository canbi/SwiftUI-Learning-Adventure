//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Can Bi on 7.02.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: Binding(
                    get: { self.order.name },
                    set: {
                        self.order.name = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    }))
                TextField("Street Address", text: Binding(
                    get: { self.order.streetAddress },
                    set: {
                        self.order.streetAddress = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    }))
                TextField("City", text: Binding(
                    get: { self.order.city },
                    set: {
                        self.order.city = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    }))
                TextField("Zip", text: Binding(
                    get: { self.order.zip },
                    set: {
                        self.order.zip = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                    }))
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }.disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
