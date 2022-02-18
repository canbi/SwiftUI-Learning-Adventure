//
//  CapsuleTextStyle.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

extension Text {
    func capsuleTextStyle(color: Color? = nil) -> some View {
        self.padding(EdgeInsets.init(top: 4, leading: 12, bottom: 4, trailing: 12))
            .background(color ?? Color("PickerBoxPrimary"))
            .foregroundColor(color != nil ? .white : Color("PickerTextColor"))
            .cornerRadius(15)
    }
}
