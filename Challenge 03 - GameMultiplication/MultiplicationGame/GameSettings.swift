//
//  GameSettings.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI

struct GameSettings: View {
    let questions = ["5","10","15","20","All"]
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Game Settings")
                .font(.title2)
            
            Stepper(value: $gameViewModel.tableChoice, in: 2...12){
                HStack{
                    Text("Multiplication Up to...")
                    Text("\(gameViewModel.tableChoice)").bold()
                }
            }
            
            Spacer()
            
            Text("How Many Questions?")
            
            Picker("How Many Questions?", selection: $gameViewModel.selectedQuestion){
                ForEach(questions, id: \.self){ index in
                    Text(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
        }
        .padding()
        .background(Color("chatColor"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        //.overlay(RoundedRectangle(cornerRadius: 16).stroke(.primary, lineWidth: 4))
    }
}
