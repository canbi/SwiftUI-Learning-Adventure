//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Can Bi on 28.01.2022.
//

import SwiftUI

struct FlagImage: View{
    var image: String
    
    var body: some View{
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
