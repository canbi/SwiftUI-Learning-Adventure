//
//  GameState.swift
//  MultiplicationGame
//
//  Created by Can Bi on 2.02.2022.
//

import SwiftUI

struct GameState: View {
    @EnvironmentObject var gmv: GameViewModel
    
    var body: some View {
        VStack{
            QuestionView()
            
            ChoiceButtonsView()
            
            ScoreView(score: $gmv.currentScore, attempt: $gmv.currentAttempt, scoreText: "Current Score")
            
            Spacer().frame(height:45)
        }
    }
}
