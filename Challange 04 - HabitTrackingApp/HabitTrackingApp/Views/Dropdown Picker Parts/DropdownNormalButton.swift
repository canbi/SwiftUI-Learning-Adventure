//
//  DropdownNormalButton.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

struct DropdownNormalButton: View{
    var buttonText: String
    var isColorful: Bool
    var colorfulColor: Color
    var index: Int
    var selection: Binding<Int>
    @Binding var showOptions: Bool
    @Binding var scrollViewFocus: Int
    
    var body: some View{
        Text(buttonText)
            .PickerBoxStyle(isColorful: isColorful, colorfulColor: colorfulColor)
            .onTapGesture {
                self.scrollViewFocus = index
                self.selection.wrappedValue = index // update user selection and close options dropdown
                showOptions = false
            }
    }
}

