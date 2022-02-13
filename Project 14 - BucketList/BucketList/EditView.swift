//
//  EditView.swift
//  BucketList
//
//  Created by Can Bi on 12.02.2022.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    @StateObject private var editVM: EditViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $editVM.name)
                    TextField("Description", text: $editVM.description)
                }
                
                Section("Nearby…") {
                    switch editVM.loadingState {
                    case .loaded:
                        ForEach(editVM.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = editVM.updateLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await editVM.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _editVM = StateObject(wrappedValue: EditViewModel(location: location))
        self.onSave = onSave
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { newLocation in }
    }
}

