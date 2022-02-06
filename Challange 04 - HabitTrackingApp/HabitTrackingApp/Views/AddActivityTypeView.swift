//
//  AddActivityTypeView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//

import SwiftUI

class EmojiSelector: ObservableObject{
    @Published var selectedEmoji: String = "✍️"
}

struct AddActivityTypeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habits: Habits
    @StateObject var emojiSelector = EmojiSelector()
    
    //Attributes
    @State private var activityTypeName = ""
    @State private var selectedColor = Color(red: 0, green: 0, blue: 0, opacity: 1)
    
    //Sheet
    @State private var selectEmoji = false
    
    //Alerts
    @State private var cantNameEmpty = false
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    HStack{
                        Text("Choose Emoji")
                        Spacer()
                        Text("\(emojiSelector.selectedEmoji)")
                            .font(.largeTitle)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                        
                    }
                    .onTapGesture {
                        selectEmoji = true
                    }
                    
                    ColorPicker("Activity Color",selection: $selectedColor)
                    
                    TextField("Activity Type Name", text: $activityTypeName)

                    }.alert(isPresented: $cantNameEmpty) {
                        Alert(title: Text("Activity type name should be set"), message: Text("Activity type name can not be empty"), dismissButton: .default(Text("Try Again")))
                }
            }
            .sheet(isPresented: $selectEmoji) {
                EmojiView(emojiSelector: emojiSelector)
            }
            .navigationBarTitle("Add New Activity Type ")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        //Activity type name should be set
                        if self.activityTypeName.count > 0 {
                            activityTypeName = self.activityTypeName
                            let newActivityType = ActivityType(emojiSelector.selectedEmoji, activityTypeName, selectedColor)
                            habits.activityTypes.append(newActivityType)
                            self.presentationMode.wrappedValue.dismiss()
                        }else {cantNameEmpty = true }
                    }){
                        HStack {
                            Image(systemName: "square.and.arrow.down.on.square.fill")
                            Text("Save")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{
                        //Close sheet
                        presentationMode.wrappedValue.dismiss()
                    }){
                        HStack {
                            Image(systemName: "xmark.square.fill")
                            Text("Close")
                        }
                    }
                }
            }
        }
    }
    
    struct AddActivityTypeView_Previews: PreviewProvider {
        static var previews: some View {
            AddActivityTypeView()
        }
    }
}
