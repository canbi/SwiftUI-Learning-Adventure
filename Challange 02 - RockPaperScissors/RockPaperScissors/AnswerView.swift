//
//  AnswerView.swift
//  RockPaperScissors
//
//  Created by Can Bi on 29.01.2022.
//

import SwiftUI

struct AnswerView: View {
    
    
    var body: some View {
        GroupBox(label: Label("🎮 Make Your Choice",  image: "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
            HStack{
                Spacer()
                HStack(alignment: .bottom, spacing: 20){
                    ForEach(0 ..< 3) { number in
                        Button(action: {self.buttonTapped(number)}){
                            Text(choices[number])
                                .font(.system(size: 50))
                                .padding(20)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .groupBoxStyle(PlainGroupBoxStyle())
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView()
    }
}
