//
//  questionView.swift
//  MultiplicationGame
//
//  Created by Can Bi on 17.07.2021.
//

import SwiftUI

struct questionView: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        //GAME SCREEN
        HStack{
            Text("\(gameViewModel.firstNumber)").font(.largeTitle).foregroundColor(Color("buttonTextColor"))
                .frame(width: 40, alignment: .trailing)
            
            Spacer().frame(width:30)
            
            Image(systemName: "multiply")
                .resizable()
                .scaledToFill()
                .frame(width: 45.0, height: 45.0)
                .foregroundColor(Color("buttonTextColor"))
            
            Spacer().frame(width:30)
            
            Text("\(gameViewModel.secondNumber)").font(.largeTitle).foregroundColor(Color("buttonTextColor"))
                .frame(width: 40, alignment: .leading)
            
        }.frame(width: screenWidth * 0.80, height: 110, alignment:.center)
        .padding()
        .background(gameViewModel.screenState ? gameViewModel.screenColor : Color("buttonColor"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background(RoundedRectangle(cornerRadius: 16)
                        .stroke(gameViewModel.screenState ? gameViewModel.screenColor : Color("buttonColor"), lineWidth: 4))
    }
}
