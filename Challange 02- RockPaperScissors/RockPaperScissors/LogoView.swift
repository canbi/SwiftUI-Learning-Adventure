//
//  LogoView.swift
//  RockPaperScissors
//
//  Created by Can Bi on 29.01.2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        GroupBox() {
            HStack{
                Spacer()
                VStack{
                    Text("✊✋✌️").font(.system(size: 60))
                    Text("RockPaperScissors").font(.title).bold()
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .groupBoxStyle(PlainGroupBoxStyle())
    }
}
