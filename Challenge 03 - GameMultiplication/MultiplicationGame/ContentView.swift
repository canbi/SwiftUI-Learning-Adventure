//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Can Bi on 12.07.2021.
//  Updated by Can Bi on 02.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gmv: GameViewModel = GameViewModel()
    
    var body: some View {
        VStack{
            VStack{
                Image("black-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            }
            
            
            VStack{
                Spacer()
                MessageBubble()
                Spacer()
            }
            
            gmv.gameState ? AnyView(GameState()) : AnyView(SettingsState())
            
            Spacer()
        }
        .padding()
        .environmentObject(gmv)
        .alert(isPresented: $gmv.currentGameEnd) {
            Alert(title: Text("Game End"), message: Text("You did a great job! Do you want to play another?"), dismissButton: .default(Text("Let's Go!")){
                    withAnimation{
                        //game ends
                        gmv.gameState = false
                        
                        //reset game attributes
                        gmv.currentScore = 0
                        gmv.currentAttempt = 0
                    }
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 8", "iPhone 13"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
