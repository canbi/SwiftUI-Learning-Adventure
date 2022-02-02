//
//  PlayButtonView.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI

struct PlayButtonView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action:{
                gameViewModel.randomizeArrays()
                gameViewModel.createRandom()
                gameViewModel.currentGameEnd = false
                withAnimation{
                    gameViewModel.gameState.toggle()
                }
            }) {
                Text("Play")
                    .font(.title)
                    .padding(.vertical,10)
                    .padding(.horizontal,40)
            }
            
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(12)
            
            Spacer()
        }
    }
}
