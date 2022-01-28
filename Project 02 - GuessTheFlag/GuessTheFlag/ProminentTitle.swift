//
//  ProminentTitle.swift
//  GuessTheFlag
//
//  Created by Can Bi on 28.01.2022.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentStyle() -> some View {
        modifier(ProminentTitle())
    }
}
