//
//  ActivityDropdown.swift
//  HabitTrackingApp
//
//  https://trailingclosure.com/dropdown-picker/
//  based on JEAN-MARC BOULLIANNE's work.
//  Created by Can Bi on 21.07.2021.
//  Updated by Can Bi on 06.02.2022.
//

import SwiftUI

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
            }.animation(nil, value: showOptions)
            .onTapGesture {
                showOptions.toggle()
            }
            
            // Drop down options
            if showOptions {
                Spacer().frame(height: 10)
                ScrollViewReader { sp in
                    ScrollView(verticalDirection ? .vertical : .horizontal, showsIndicators: false) {
                        HStack{
                            Group{
                                verticalDirection ?
                                AnyView( //VERTICAL
                                    DropdownVerticalView(addButton: addButton, addButtonText: addButtonText, addButtonSelect: addButtonSelect, options: options, isColorful: isColorful, colors: colors, deletingButton: deletingButton, selection: selection, showOptions: $showOptions, scrollViewFocus: $scrollViewFocus, removingAlert: $removingAlert, willRemove: $willRemove)
                                )
                                :
                                AnyView( //HORIZONTAL
                                    DropdownHorizontalView(addButton: addButton, addButtonText: addButtonText, addButtonSelect: addButtonSelect, options: options, isColorful: isColorful, colors: colors, deletingButton: deletingButton, selection: selection, showOptions: $showOptions, scrollViewFocus: $scrollViewFocus, removingAlert: $removingAlert, willRemove: $willRemove)
                                )
                            }
                            .onAppear{
                                sp.scrollTo(scrollViewFocus)
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
