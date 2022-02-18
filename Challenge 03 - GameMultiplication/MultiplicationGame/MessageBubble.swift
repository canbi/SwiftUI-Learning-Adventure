//
//  MessageBubble.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI

struct MessageBubble: View {
    @EnvironmentObject var gmv: GameViewModel
    private var welcomeMessage: String =  "Are you ready to play?"
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .leading){
                    Text("\(gmv.animals[gmv.currentAttempt].capitalized)")
                        .font(.title2)
                        .foregroundColor(.red)
                    
                    Text("\(gmv.gameState ? (gmv.wonRound ? gmv.winPhrases[gmv.currentAttempt] :gmv.losePhrases[gmv.currentAttempt]) :  welcomeMessage)")
                        .font(.body)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .padding(.trailing)
            .padding(.leading,50)
            .fixedSize(horizontal: false, vertical: true)
            .background(Color("chatColor"))
            .cornerRadius(20)
            .padding(.leading, 40)
            .padding(.bottom, 60)
            
            HStack{
                Image(gmv.animals[gmv.currentAttempt])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                Spacer()
            }
        }.animation(nil, value: gmv.currentAttempt)
    }
}
