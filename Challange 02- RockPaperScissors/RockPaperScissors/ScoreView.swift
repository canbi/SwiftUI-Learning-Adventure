//
//  ScoreView.swift
//  RockPaperScissors
//
//  Created by Can Bi on 29.01.2022.
//

import SwiftUI

struct ScoreView: View {
    var userScore:Int
    
    var body: some View {
        GroupBox(label: Label("🎯 Score", image: "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
            Text("\(userScore)").font(.largeTitle).bold()
        }.groupBoxStyle(PlainGroupBoxStyle())
    }
}
