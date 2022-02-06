//
//  EmojiView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//

import SwiftUI

struct EmojiView : View {
    @Environment(\.presentationMode) var presentationMode
    
    var emojis: [[String]] = [
        ["💪","✍️","🧑‍🏫","🧑‍💻"],
        ["💃","🕺","🏃","🚶"],
        ["🍳","🥗","🍻","⚽️"],
        ["🏀","🎾","🏐","🎱"],
        ["🧗","🚵","🚴","⛹️"],
        ["🤾","🏌️","🤽","🏄"],
        ["🧘","🎭","🎨","🎬"],
        ["🎹","🎧","🥁","🎸"],
        ["🎻","🎮","🧩","🚗"],
        ["🛵","💻","🪥","🧼"],
        ["🛏","📨","📚","📝"]]
    
    @ObservedObject var emojiSelector = EmojiSelector()
    
    var body : some View{
        ScrollView(.vertical) {
            HStack{
                Spacer()
                VStack(spacing: 15){
                    ForEach(emojis,id: \.self){i in
                        HStack(spacing: 25){
                            ForEach(i,id: \.self){j in
                                Button(action: {
                                    emojiSelector.selectedEmoji = j
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Text("\(j)").font(.system(size: 55))
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .cornerRadius(25)
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView()
    }
}
