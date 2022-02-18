//
//  ScoreView.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI

struct ScoreView: View {
    @Binding var score: Int
    @Binding var attempt: Int
    var scoreText: String
    
    var body: some View {
        HStack(spacing: 0){
            Spacer()
            Text("\(scoreText)").font(.title2)
            Spacer()
            VStack{
                Text("\(score)")
                Divider().frame(width: 20)
                Text("\(attempt)")
            }
            Spacer()
        }.padding()
    }
}
