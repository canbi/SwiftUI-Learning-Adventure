//
//  QuestionView.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI


struct QuestionView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        //GAME SCREEN
        VStack{
            HStack{
                Text("Multiplication Turn")
                Text("\(gameViewModel.currentGameEnd ? gameViewModel.currentAttempt :gameViewModel.currentAttempt+1)")
                Spacer()
            }.font(.title2)
            
            HStack{
                Text("\(gameViewModel.firstNumber)")
                    .font(.largeTitle)
                    .frame(width: 40, alignment: .trailing)
                
                Image(systemName: "multiply")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25.0, height: 25.0)
                    .padding(.horizontal,40)

                Text("\(gameViewModel.secondNumber)")
                    .font(.largeTitle)
                    .frame(width: 40, alignment: .leading)
            }
                
        }.padding()
            .background(gameViewModel.screenState ? gameViewModel.screenColor : Color("chatColor"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background(RoundedRectangle(cornerRadius: 16)
                            .stroke(gameViewModel.screenState ? gameViewModel.screenColor : Color("chatColor"), lineWidth: 4))
            
        
    }
}
