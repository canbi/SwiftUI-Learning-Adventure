//
//  SettingsState.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI

struct SettingsState: View {
    @EnvironmentObject var gmv: GameViewModel
    
    var body: some View {
        VStack{
            GameSettings()
            
            ScoreView(score: $gmv.totalScore, attempt: $gmv.totalAttempt, scoreText: "Total Score")
            
            PlayButtonView()
        }
    }
}
