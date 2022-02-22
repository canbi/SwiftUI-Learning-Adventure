//
//  ImageOverlay.swift
//  SnowSeeker
//
//  https://www.simpleswiftguide.com/how-to-add-text-overlay-on-image-in-swiftui/
//  Updated by Can Bi on 22.02.2022.
//

import SwiftUI

struct ImageOverlay: View {
    var text: String
    
    var body: some View {
        ZStack {
            Text("Credit: \(text)")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }
        .background(Color.black)
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(10)
    }
}
