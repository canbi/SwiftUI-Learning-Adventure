//
//  DropdownAddButton.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

struct DropdownAddButton: View{
    var buttonText: String
    var addButtonSelect: Binding<Bool>?
    
    var body: some View{
        Text(buttonText)
            .padding(EdgeInsets.init(top: 4, leading: 12, bottom: 4, trailing: 12))
            .background(Color("PickerBoxSecondary"))
            .cornerRadius(15)
            .onTapGesture {
                self.addButtonSelect!.wrappedValue.toggle()
            }
    }
}
