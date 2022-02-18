//
//  AddActivityTypeView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//  Updated by Can Bi on 06.02.2022.
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
    
    @State private var selectEmoji = false //Sheet
    @State private var cantNameEmpty = false //Alerts
    
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
                        guard self.activityTypeName.count > 0 else {
                            cantNameEmpty = true
                            return
                        }
                        
                        activityTypeName = self.activityTypeName
                        let newActivityType = ActivityType(emojiSelector.selectedEmoji, activityTypeName, selectedColor)
                        habits.activityTypes.append(newActivityType)
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        HStack {
                            Image(systemName: "square.and.arrow.down.on.square.fill")
                            Text("Save")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{
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
