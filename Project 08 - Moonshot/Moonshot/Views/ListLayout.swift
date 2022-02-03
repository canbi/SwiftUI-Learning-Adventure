//
//  ListLayout.swift
//  Moonshot
//
//  Created by Can Bi on 3.02.2022.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    
    var body: some View {
        List{
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                    }.listRowBackground(Color.orange)
                }
            }
        }
    }
    
    init(missions: [Mission], astronauts: [String: Astronaut]){
        self.missions = missions
        self.astronauts = astronauts
        UITableView.appearance().backgroundColor = .clear
    }
}
