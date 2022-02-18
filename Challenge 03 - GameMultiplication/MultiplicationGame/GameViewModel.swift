//
//  GameViewModel.swift
//  MultiplicationGame
//
//  Created by Can Bi on 18.07.2021.
//  Updated by Can Bi on 02.02.2022.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var animals = ["bear", "buffalo","chick","cow","chicken","crocodile","dog","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rabbit","rhino","sloth","snake","walrus","whale","zebra"]
    
    @Published var winPhrases = ["I appreciate your help.","How do you feel about that?","I’m glad you enjoy learning!","I’ll bet you knew you could do it!","You make my job easy.","You’re really giving that your best!","You’re the bright spot in my day.","You’re really improving.","You’re getting better!","Now you have it.","Now you’ve figured it out!","That’s really creative.","Thanks for helping make this a good day!","Nice going!","That’s the way to do it.","You did it that time!","Hey, you did it!","I’m so happy for you.","You must feel pretty proud!","You must feel good about that.","You’ve made a lot of progress.","I like the way you handled that!","Good remembering.","You’re fun to be around.","You must’ve been practicing.","You were a real help today.","I appreciate your help.","Give yourself a pat on the back!","You did a lot of work today!","Look how far you’ve come!","You’re improving!","You’re really getting that hang of it.","I have a nice time when you are along.","Being with you is a treat for me!","You made it!","You did it all by yourself.","You are a good friend","Thank you for contributing to our family","It’s fun to do things with you","I’m glad you’re here"]

    @Published var losePhrases = ["I can see you’re really trying!", "Keep on trying!","You almost got it!","I can see you tried hard.","You’ve just about got it.","One more time and you’ll have it!","I believe in you.","I trust you.","That’s a tough one, but I’ll be you can figure it out.","I think you can do it!","I have faith in you","You can learn from your mistakes","When you make a mistake, you are still beautiful","Don’t panic — you’ve prepared all you can.","I know you’ll try your hardest.","Take your time and do your best, that’s all you can do.","We will never be disappointed in you. We know how hard you work.", "Do not worry about failing. You’ll be a winner as long as you try your best.","You are strong.","The effort you put in is more important than winning.","I admire your determination.","Don’t give up when things get tough.", "You can make a difference.","We are here to help you.","You are not alone in this.", "We all have bad days sometimes.", "You’re home now. Would you like a hug?", "This will be worth it.", "There’s nothing wrong with making mistakes.", "We make mistakes so we can learn from them.","No matter what happens, I love you.","It’s OK to give up sometimes.", "Nothing you can do could ever stop me from loving you."]
    
    //Attributes
    @Published var tableChoice = 5
    @Published var selectedQuestion = "5"
    @Published var answers = [0,0,0]
    @Published var firstNumber = 0
    @Published var secondNumber = 0
    @Published var totalAttempt = 0 {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(totalAttempt) {
                UserDefaults.standard.set(encoded, forKey: "totalAttempt")
            }
            else{
                fatalError("Failed to encode totalAttempt to bundle.")
            }
        }
    }
    @Published var totalScore = 0 {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(totalScore) {
                UserDefaults.standard.set(encoded, forKey: "totalScore")
            }
            else{
                fatalError("Failed to encode totalScore to bundle.")
            }
        }
    }
    @Published var currentAttempt = 0
    @Published var currentScore = 0
    @Published var screenColor = Color.white
    
    //States
    @Published var gameState = false
    @Published var currentGameEnd = false
    @Published var screenState = false
    @Published var wonRound = false
    
    
    init() {
        //LOAD FROM STORE
        if let totalAttemptStore = UserDefaults.standard.data(forKey: "totalAttempt") {
            let decoder = JSONDecoder()
            if let decodedTotalAttempt = try? decoder.decode(Int.self, from: totalAttemptStore) {
                self.totalAttempt = decodedTotalAttempt
            }
            else{
                fatalError("Failed to decode totalAttempt from bundle.")
            }
        }
        
        if let totalScoreStore = UserDefaults.standard.data(forKey: "totalScore") {
            let decoder = JSONDecoder()
            if let decodedTotalScore = try? decoder.decode(Int.self, from: totalScoreStore) {
                self.totalScore = decodedTotalScore
            }
            else{
                fatalError("Failed to decode totalScore from bundle.")
            }
        }
    }
    
    func buttonTapped(_ number: Int){
        if number == firstNumber*secondNumber {
            screenColor = Color(.green)
            wonRound = true
            currentScore += 1
        } else {
            wonRound = false
            screenColor = Color(.red)
        }
        currentAttempt += 1
        
        withAnimation{
            screenState = true
        }
        buttonColor()
        
        //Check if game finished or not
        let nof_question = selectedQuestion == "All" ? 30 : Int(selectedQuestion) ?? 5
        
        if currentAttempt == nof_question{
            //update total score & attempt
            totalScore += currentScore
            totalAttempt += currentAttempt
            
            //the current game is finished, show pop-up alert
            currentGameEnd = true
        }
        else{
            createRandom()
        }
    }
    
    func randomizeArrays(){
        animals.shuffle()
        winPhrases.shuffle()
        losePhrases.shuffle()
    }
    
    func createRandom(){
        firstNumber = Int.random(in: 0...tableChoice)
        secondNumber = Int.random(in: 0...tableChoice)
        
        answers[0] = firstNumber*secondNumber
        
        for i in 1...2 {
            var result = firstNumber * Int.random(in: 0...tableChoice)
            
            //if it is not unique
            while (answers.contains(result)){
                result = Int.random(in: 0...tableChoice) * Int.random(in: 0...tableChoice)
            }
            answers[i] = result
        }
        
        answers.shuffle()
    }
    
    func buttonColor(){
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
            withAnimation{
                self.screenState = false
            }
        })
    }
}
