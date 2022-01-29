//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Can Bi on 5.07.2021.
//  Updated by Can Bi on 29.01.2021.
//

import SwiftUI

struct PlainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

enum ScoreType: String {
    case draw = "DRAW"
    case win = "WIN"
    case lose = "LOSE"
}

enum RoundResult: String {
    case correct = "CORRECT"
    case wrong = "WRONG"
}

struct ContentView: View {
    private var choices = ["✊","✋","✌️"]
    private var roundLimit = 10
    
    @State private var compChoice = Int.random(in: 0..<2)
    @State private var shouldWin = Bool.random()
    @State private var scoreTitle = ScoreType.draw
    @State private var userScore = 0
    @State private var roundNumber = 1
    @State private var roundResult = RoundResult.correct
    @State private var showingRound = false
    @State private var showingEnd = false
    
    func buttonTapped(_ number: Int) {
        //calculations
        let total = number + compChoice
        if (number == compChoice){
            scoreTitle = ScoreType.draw
        }
        else if (total == 1){ //Paper win
            scoreTitle = number ==  1 ? ScoreType.win : ScoreType.lose
        }
        else if (total == 2){//Rock win
            
            scoreTitle = number ==  0 ? ScoreType.win : ScoreType.lose
        }
        else{ //Scissors Win
            scoreTitle = number ==  2 ? ScoreType.win : ScoreType.lose
        }
        
        //update score
        if (scoreTitle == ScoreType.win && shouldWin == true){
            userScore += 1
            roundResult = RoundResult.correct
        }
        else if (shouldWin == false && scoreTitle == ScoreType.lose ){
            userScore += 1
            roundResult = RoundResult.correct
        }
        else {
            userScore -= 1
            roundResult = RoundResult.wrong
        }
        
        //game over control
        if roundNumber == roundLimit{
            showingEnd = true
        } else{
            showingRound = true
        }
        
    }
    
    func newRound() {
        compChoice = Int.random(in: 0..<2)
        shouldWin = Bool.random()
        roundNumber += 1
    }
    
    func endGame() {
        compChoice = Int.random(in: 0..<2)
        roundNumber = 1
        userScore = 0
    }
    
    var body: some View {
        VStack{
            Spacer()
            
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
            
            Spacer()
            
            HStack{
                GroupBox(label: Label("🎯 Score", image: "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
                    Text("\(userScore)").font(.largeTitle).bold()
                }
                Spacer()
                GroupBox(label: Label("🏅 Round", image: "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
                    Text("\(roundNumber)").font(.largeTitle).bold()
                }
            }
            .padding(.horizontal)
            .groupBoxStyle(PlainGroupBoxStyle())
            
            Spacer()
            
            GroupBox(label: Label("🖥️ Computer", image: "").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
                HStack{
                    Spacer()
                    Text("Computer Will Play")
                    Spacer()
                    Text(choices[compChoice]).font(.system(size: 50))
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
            .alert(isPresented: $showingRound) {
                Alert(
                    title: Text("\(roundResult.rawValue)"),
                    message: Text("\(roundResult.rawValue == RoundResult.correct.rawValue ? "You won this round" : "You lost this round")"),
                    dismissButton: .default(Text("Next Round")) {
                        self.newRound()
                    })
            }
            
            Spacer()
            
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
            .alert(isPresented: $showingEnd) {
                Alert(title: Text("GAME OVER"), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("New Game")) {
                    self.endGame()
                })
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
