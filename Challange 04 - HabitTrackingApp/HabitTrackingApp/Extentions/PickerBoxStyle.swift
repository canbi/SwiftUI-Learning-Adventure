//
//  PickerBoxStyle.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

extension Text {
    func PickerBoxStyle(isColorful: Bool, colorfulColor: Color) -> some View {
        self.padding(EdgeInsets.init(top: 4, leading: 12, bottom: 4, trailing: 12))
            .background(isColorful ? colorfulColor : Color("PickerBoxPrimary"))
            .foregroundColor(isColorful ? .white : Color("PickerTextColor"))
            .cornerRadius(15)
    }
}
