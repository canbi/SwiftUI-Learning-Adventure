//
//  Extentions.swift
//  RockPaperScissors
//
//  Created by Can Bi on 29.01.2022.
//

import SwiftUI

struct Title: ViewModifier {
    let font = Font.system(.title).weight(.bold)
    
    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

extension Image {
    func imageModifier() -> some View {
        self
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
    }
}
