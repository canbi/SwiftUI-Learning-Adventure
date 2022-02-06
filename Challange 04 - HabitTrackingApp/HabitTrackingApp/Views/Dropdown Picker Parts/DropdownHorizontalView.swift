//
//  DropdownHorizontalView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

struct DropdownHorizontalView: View{
    var addButton: Bool?
    var addButtonText: String?
    var addButtonSelect: Binding<Bool>?
    var options: [String]
    var isColorful: Bool?
    var colors: [Color]?
    var deletingButton: Bool
    var selection: Binding<Int>
    @Binding var showOptions: Bool
    @Binding var scrollViewFocus: Int
    @Binding var removingAlert:  Bool
    @Binding var willRemove: Int
    
    var body: some View{
        VStack{
            HStack{
                if addButton ?? false{
                    DropdownAddButton(buttonText: self.addButtonText ?? "Add New", addButtonSelect: addButtonSelect)
                }
                
                ForEach(options.indices, id: \.self) { index in
                    HStack{
                        if index == selection.wrappedValue {
                            DropdownSelectedButton(buttonText: options[index], isColorful:  isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"), showOptions: $showOptions)
                        } else if deletingButton{
                            ZStack{
                                DropdownNormalButton(buttonText: options[index], isColorful: isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"), index: index, selection: selection, showOptions: $showOptions, scrollViewFocus: $scrollViewFocus)
                                    .padding(.trailing, 10)
                                
                                HStack(alignment: .firstTextBaseline){
                                    Spacer()
                                    Button(action: {
                                        willRemove = index
                                        removingAlert = true
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(Color("PickerBoxSecondary"))
                                    }
                                }
                            }.zIndex(1)
                        }
                        else{
                            DropdownNormalButton(buttonText: options[index], isColorful: isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"), index: index, selection: selection, showOptions: $showOptions, scrollViewFocus: $scrollViewFocus)
                        }
                    }
                }
            }
            
            Spacer().frame(height: 10)
        }
    }
}



