//
//  ActivityTypeTitleCapsule.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

struct ActivityTypeTitleCapsule: View {
    var mame: String
    var color: Color
    var emoji: String
    var textSize: CGFloat
    var emojiSize: CGFloat
    
    var body: some View {
        ZStack{
            HStack{
                Text(mame)
                    .bold()
                    .font(.system(size: textSize))
                    .foregroundColor(.white)
                    .padding(EdgeInsets.init(top: 4, leading: emojiSize+10, bottom: 4, trailing: 15))
                    .fixedSize(horizontal: true, vertical: true)
                    .background(RoundedRectangle(cornerRadius: textSize).fill(color))
                Spacer()
            }
            
            HStack{
                Text(emoji)
                    .font(.system(size: emojiSize))
                    .padding(.leading,4)
                Spacer()
            }
        }
    }
}
