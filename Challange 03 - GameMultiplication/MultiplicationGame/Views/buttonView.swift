//
//  buttonView.swift
//  MultiplicationGame
//
//  Created by Can Bi on 18.07.2021.
//

import SwiftUI

struct playButtonView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action:{
                withAnimation{
                    gameViewModel.randomizeArrays()
                    gameViewModel.createRandom()
                    gameViewModel.gameState.toggle()
                    gameViewModel.currentGameEnd = false
                }
            }) {
                Text("Play")
                    .font(.title)
                    .frame(width:100,height: 60)
            }
            .frame(width:100,height: 60)
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(16)
            
            Spacer()
        }
    }
}


struct choiceButtonsView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View{
        HStack{
            ForEach(gameViewModel.answers, id: \.self) { result in
                Button(action:{
                    withAnimation{
                        gameViewModel.buttonTapped(result)
                    }
                }) {
                    Text("\(result)")
                        .font(.title2)
                        .frame(width:100,height: 60)
                }
                .padding()
                .frame(width:100,height: 60)
                .background(Color("buttonColor"))
                .foregroundColor(Color("buttonTextColor"))
                .cornerRadius(16)
            }
        }
    }
}
