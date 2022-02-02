//
//  messageBubble.swift
//  MultiplicationGame
//
//  Created by Can Bi on 17.07.2021.
//

import SwiftUI

struct messageBubble: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        //GAMIFICATION
        ZStack{
            HStack{
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color("chatColor"))
                    
                    HStack(alignment: .center, spacing: 0){
                        Spacer()
                        if(gameViewModel.gameState){
                            Text("\(gameViewModel.wonRound ? gameViewModel.winPhrases[gameViewModel.currentAttempt] :gameViewModel.losePhrases[gameViewModel.currentAttempt])")
                                .font(.title3)
                                .foregroundColor(Color("messageTextColor"))
                                .multilineTextAlignment(.trailing)
                                .frame(width: screenWidth * 0.7, height: screenHeight * 0.1)
                            Spacer().frame(width: 20)
                        }
                        else{
                            Text("Are you ready to play?")
                                .font(.title2)
                                .foregroundColor(Color("messageTextColor"))
                                .frame(width: screenWidth * 0.7, height: screenHeight * 0.1, alignment: .center)
                        }
                    }
                }.frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
            }
            
            HStack{
                Image(gameViewModel.animals[gameViewModel.currentAttempt])
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.2, height: screenHeight * 0.2, alignment: .bottomLeading)
                    
                
                Text("\(gameViewModel.animals[gameViewModel.currentAttempt].capitalized)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                    .frame(height: screenHeight * 0.2, alignment: .bottomLeading)
                
                Spacer()
            }
        }
        .frame(width: screenWidth * 0.9, height: screenHeight * 0.1)
        .animation(nil)
    }
}
