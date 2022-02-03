//
//  ContentView.swift
//  Moonshot
//
//  Created by Can Bi on 3.02.2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingGrid: Bool = true
    
    var body: some View {
        NavigationView {
            Group {
                showingGrid ?
                AnyView(GridLayout(missions: missions, astronauts: astronauts))
                : AnyView(ListLayout(missions: missions, astronauts: astronauts))
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Change View") {
                        showingGrid.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
