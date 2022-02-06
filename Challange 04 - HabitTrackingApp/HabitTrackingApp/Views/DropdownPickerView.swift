//
//  ActivityDropdown.swift
//  HabitTrackingApp
//
//  https://trailingclosure.com/dropdown-picker/
//  based on JEAN-MARC BOULLIANNE's work.
//  Created by Can Bi on 21.07.2021.

import SwiftUI


extension Text {
    func PickerBoxStyle(isColorful: Bool, colorfulColor: Color) -> some View {
        self.padding(EdgeInsets.init(top: 4, leading: 12, bottom: 4, trailing: 12))
            .background(isColorful ? colorfulColor : Color("PickerBoxPrimary"))
            .foregroundColor(isColorful ? .white : Color("PickerTextColor"))
            .cornerRadius(15)
    }
}

struct DropdownPickerView: View {
    var title: String
    var selection: Binding<Int>
    var options: [String]
    @State private var showOptions: Bool = false
    @EnvironmentObject var habits: Habits
    
    var addButton: Bool?
    var addButtonText: String?
    var addButtonSelect: Binding<Bool>?
    var deletingButton: Bool
    var verticalDirection: Bool
    var isColorful: Bool?
    var colors: [Color]?
    
    @State var scrollViewFocus = 0
    
    //Alert
    @State private var removingAlert = false
    @State private var willRemove = 0
    
    //without add button
    init(title: String,selection: Binding<Int>,options: [String], deletingButton: Bool,verticalDirection: Bool, isColorful: Bool? = nil, colors: [Color]? = nil){
        self.title = title
        self.selection = selection
        self.options = options
        self.deletingButton = deletingButton
        self.verticalDirection = verticalDirection
        self.isColorful = isColorful
        self.colors = colors
    }
    
    //with add button
    init(title: String,selection: Binding<Int>,options: [String], deletingButton: Bool, verticalDirection: Bool,isColorful: Bool? = nil, colors: [Color]? = nil, addButtonText: String, addButtonSelect: Binding<Bool>){
        self.init(title: title, selection: selection, options: options, deletingButton: deletingButton, verticalDirection: verticalDirection, isColorful: isColorful, colors: colors)
        self.addButton = true
        self.addButtonText = addButtonText
        self.addButtonSelect = addButtonSelect
    }
    
    func removeItems(at offset: Int) {
        habits.activityTypes.remove(at: offset)
    }
    
    fileprivate func addButtonTextView(_ text: String) -> some View {
        return Text(text)
            .padding(EdgeInsets.init(top: 4, leading: 12, bottom: 4, trailing: 12))
            .background(Color("PickerBoxSecondary"))
            .cornerRadius(15)
            .onTapGesture {
                self.addButtonSelect!.wrappedValue.toggle()
            }
    }
    
    fileprivate func selectedButtonView(_ text: String, isColorful: Bool, colorfulColor: Color) -> some View {
        Text(text)
            .PickerBoxStyle(isColorful: isColorful, colorfulColor: colorfulColor)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black, lineWidth: 1.5)
            )
            .onTapGesture {
                showOptions = false // hide dropdown options - user selection didn't change
            }
    }
    
    fileprivate func normalButtonView(_ text: String, index: Int,  isColorful: Bool, colorfulColor: Color) -> some View {
        Text(text)
            .PickerBoxStyle(isColorful: isColorful, colorfulColor: colorfulColor)
            .onTapGesture {
                self.scrollViewFocus = index
                self.selection.wrappedValue = index // update user selection and close options dropdown
                showOptions = false
            }
    }
    
    var body: some View {
        VStack{
            if showOptions{
                Spacer().frame(height:6)
            }
            HStack {
                Text(title)
                Spacer()
                Text(options[selection.wrappedValue])
                    .foregroundColor(Color("PickerTextColor").opacity(0.4))
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
            }
            .onTapGesture {
                // show the dropdown options
                if showOptions{
                    showOptions = false
                }else{
                    showOptions = true
                }
            }
            
            // Drop down options
            if showOptions {
                Spacer().frame(height: 10)
                ScrollViewReader { sp in
                    ScrollView(verticalDirection ? .vertical : .horizontal, showsIndicators: false) {
                        HStack{
                            //VERTICAL
                            if verticalDirection {
                                VStack(alignment:.leading, spacing: 8) {
                                    //ADD BUTTON
                                    if addButton ?? false{
                                        addButtonTextView(self.addButtonText ?? "Add New")
                                    }
                                    //ELEMENTS
                                    ForEach(options.indices, id: \.self) { index in
                                        HStack{
                                            //SELECTED ONE
                                            if index == selection.wrappedValue {
                                                selectedButtonView(options[index],isColorful: isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"))
                                                
                                            } else {
                                                normalButtonView(options[index], index: index, isColorful: isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"))
                                                
                                                Spacer()
                                                
                                                if deletingButton{
                                                    Button(action: {
                                                        willRemove = index
                                                        removingAlert = true
                                                    }) {
                                                        Image(systemName: "minus.circle.fill")
                                                            .foregroundColor(Color("PickerBoxSecondary"))
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    Spacer().frame(height: 2)
                                }.onAppear{
                                    sp.scrollTo(scrollViewFocus)
                                }
                            }
                            //HORIZONTAL
                            else {
                                VStack{
                                    HStack{
                                        //ADD BUTTON
                                        if addButton ?? false{
                                            addButtonTextView(self.addButtonText ?? "Add New")
                                        }
                                        //ELEMENT
                                        ForEach(options.indices, id: \.self) { index in
                                            HStack{
                                                //SELECTED ONE
                                                if index == selection.wrappedValue {
                                                    selectedButtonView(options[index],isColorful: isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"))
                                                } else if deletingButton{
                                                    ZStack{
                                                        normalButtonView(options[index], index: index, isColorful: isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"))
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
                                                    }
                                                }
                                                else{
                                                    normalButtonView(options[index], index: index, isColorful: isColorful ?? false, colorfulColor: colors?[index] ?? Color("PickerBoxPrimary"))
                                                }
                                            }
                                        }
                                    }
                                    Spacer().frame(height: 10)
                                }.onAppear{
                                    sp.scrollTo(scrollViewFocus)
                                }
                            }
                            Spacer()
                            .alert(isPresented: $removingAlert) {
                                Alert(title: Text("Do you want to delete \(options[willRemove])?"),
                                  message: Text("You can not undo this."),
                                  primaryButton: .destructive(Text("Delete")) {
                                    
                                    if willRemove <= selection.wrappedValue{
                                        selection.wrappedValue -= 1 //Bug fixed
                                    }
                                    
                                    removeItems(at: willRemove)
                                  },
                                  secondaryButton: .cancel())
                            }
                        }
                    }
                }
                .frame(maxHeight: 250)
                .padding(.vertical, 2)
            }
        }
    }
}
