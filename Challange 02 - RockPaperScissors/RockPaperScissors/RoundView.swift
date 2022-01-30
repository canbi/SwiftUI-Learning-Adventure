//
//  RoundView.swift
//  RockPaperScissors
//
//  Created by Can Bi on 29.01.2022.
//

import SwiftUI

struct RoundView: View {
    var roundNumber: Int
    var body: some View {
        GroupBox(label: Label("🏅 Round", image: "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
            Text("\(roundNumber)").font(.largeTitle).bold()
        }.groupBoxStyle(PlainGroupBoxStyle())
    }
}
