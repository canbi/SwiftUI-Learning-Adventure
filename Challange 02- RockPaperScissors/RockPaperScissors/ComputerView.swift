//
//  ComputerView.swift
//  RockPaperScissors
//
//  Created by Can Bi on 29.01.2022.
//

import SwiftUI

struct ComputerView: View {
    var computerChoice: String
    var shouldWin: Bool
    
    var body: some View {
        GroupBox(label: Label("🖥️ Computer", image: "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
            HStack{
                Spacer()
                Text("Computer Will Play")
                Spacer()
                Text(computerChoice).font(.system(size: 50))
                Spacer()
                VStack(alignment: .center){
                    Text("You should")
                    Text("\((shouldWin ? ScoreType.win : ScoreType.lose).rawValue)")
                        .foregroundColor(shouldWin ? .green : .red)
                        .bold()
                }
                Spacer()
            }
        }
        .font(.title2)
        .padding(.horizontal)
        .groupBoxStyle(PlainGroupBoxStyle())
    }
}
