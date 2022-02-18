//
//  EmojiView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//  Updated by Can Bi on 06.02.2022.
//

import SwiftUI

struct EmojiView : View {
    @Environment(\.presentationMode) var presentationMode
    
    var emojis: [String] = ["💪","✍️","🧑‍🏫","🧑‍💻","💃","🕺","🏃","🚶","🍳","🥗","🍻","⚽️",
                            "🏀","🎾","🏐","🎱","🧗","🚵","🚴","⛹️","🤾","🏌️","🤽","🏄",
                            "🧘","🎭","🎨","🎬","🎹","🎧","🥁","🎸","🎻","🎮","🧩","🚗",
                            "🛵","💻","🪥","🧼","🛏","📨","📚","📝"]
    
    @ObservedObject var emojiSelector = EmojiSelector()
    
    let columns = [GridItem(.adaptive(minimum: 75))]
    
    var body : some View{
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(emojis,id: \.self){ emoji in
                    Button(action: {
                        emojiSelector.selectedEmoji = emoji
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("\(emoji)").font(.system(size: 55))
                    }
                }
            }.padding()
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView()
    }
}
