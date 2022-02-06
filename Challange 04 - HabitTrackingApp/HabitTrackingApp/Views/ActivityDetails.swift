//
//  ActivityDetails.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

struct ActivityDetails: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habits: Habits
    
    @State var activity: Activity
    @State private var currentNote: String = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationView {
            VStack{
                HStack(alignment:.top){

                    VStack(alignment: .leading){
                        Text("Activity Type")
                        DividerView()
                        ActivityTypeTitleCapsule(mame: activity.activityType.name,
                                                 color: activity.activityType.color,
                                                 emoji: activity.activityType.emoji,
                                                 textSize: 20,
                                                 emojiSize: 32)
                        
                        activity.description.count > 0 ? Text("\(activity.description)")
                            .capsuleTextStyle() : nil
                    }
                    

                    VStack(alignment: .trailing){
                        Text("Progress")
                        DividerView()
                        Text("\(activity.goalProgress)")
                            .capsuleTextStyle(color: activity.goalProgress < 50 ? Color.red : Color.green)
                    }
                }.padding(.bottom)
                
                VStack(alignment: .leading){
                    Text("Tracking Type")
                    DividerView()
                    HStack{
                        Text(activity.routine).capsuleTextStyle()
                        Text(activity.milestone.value).capsuleTextStyle(color: activity.milestone.color)
                    }
                }.padding(.bottom)

                VStack(alignment: .leading){
                    Text("Start Date")
                    DividerView()
                    HStack{
                        Text(dateFormatter.string(from: activity.startDate)).capsuleTextStyle(color: Color.pink)
                        Text(timeFormatter.string(from: activity.startDate)).capsuleTextStyle(color: Color.pink)
                    }
                }.padding(.bottom)
                
                VStack(alignment: .leading){
                    Text("Notes")
                    DividerView()
                    HStack{
                        TextField("Add Note", text: $currentNote)
                        Button("Add note"){
                            guard self.currentNote.count > 0 else {
                                return
                            }
                            
                            activity.appendNote(newNote: currentNote)
                            currentNote = ""
                        }
                    }
                    ForEach(activity.userNotes, id:\.self) { note in
                        Text(note)
                    }
                    
                }.padding(.bottom)
                Spacer()
                
            }
            .navigationBarTitle(activity.title)
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        guard let foundActivityIndex = habits.activities.firstIndex(where: { $0.id == activity.id })
                        else {
                            //TODO alert
                            //TODO dismiss sheet
                            return
                        }
                        
                        habits.activities[foundActivityIndex] = activity
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
}
