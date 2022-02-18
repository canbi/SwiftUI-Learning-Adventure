//
//  ChoiceButtonsView.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI


struct ChoiceButtonsView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View{
        HStack{
            ForEach(gameViewModel.answers, id: \.self) { result in
                Button(action:{
                    gameViewModel.buttonTapped(result)
                }) {
                    Text("\(result)")
                        .font(.title)
                        .padding(.vertical,20)
                        .padding(.horizontal,30)
                        .frame(maxWidth: .infinity)
                        .background(Color("chatColor"))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }
            }
        }
    }
}
