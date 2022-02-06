//
//  DropdownSelectedButton.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

struct DropdownSelectedButton: View{
    var buttonText: String
    var isColorful: Bool
    var colorfulColor: Color
    @Binding var showOptions: Bool
    
    var body: some View{
        Text(buttonText)
            .PickerBoxStyle(isColorful: isColorful, colorfulColor: colorfulColor)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black, lineWidth: 1.5)
            )
            .onTapGesture {
                showOptions = false // hide dropdown options - user selection didn't change
            }
    }
}
