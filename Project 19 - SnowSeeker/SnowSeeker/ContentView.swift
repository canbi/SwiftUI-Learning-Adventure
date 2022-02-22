//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Can Bi on 22.02.2022.
//

import SwiftUI

enum sortTypes {
    case alphabetical
    case country
    case none
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var isShowingSorting = false
    @State private var sortType: sortTypes = sortTypes.none
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
                .swipeActions {
                    let isFavorited = favorites.contains(resort)
                    Button {
                        if isFavorited {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    } label: {
                        Label(isFavorited ? "Unfavorite" : "Favorite",
                              systemImage: isFavorited ? "heart.slash" : "heart.fill")
                    }
                    .tint(isFavorited ? .blue : .red)
                }
                .confirmationDialog("Sort Settings", isPresented: $isShowingSorting) {
                    Button("Default Order") { sortType = .none }
                    Button("Sorted by Alphabetical") { sortType = .alphabetical}
                    Button("Sorted by Country") { sortType = .country }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Select a new sorting")
                }
                
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSorting = true
                    } label: {
                        Label("Sort Settings", systemImage: "arrow.up.arrow.down.square")
                    }
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyStackNavigationView()
    }
    
    var filteredResorts: [Resort] {
        var sortedResorts = resorts
        
        
        if sortType == .alphabetical {
            sortedResorts.sort{ $0.name < $1.name }
        }
        else if sortType == .country {
            sortedResorts.sort{ $0.country < $1.country }
        }
        
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
