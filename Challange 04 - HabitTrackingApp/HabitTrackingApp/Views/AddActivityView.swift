//
//  AddActivityView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habits: Habits
    
    //Attributes
    @State private var title = ""
    @State private var description = ""
    @State private var activityType = 0
    @State private var routineType  = 0
    @State private var trackingType = 0
        
    @State private var milestoneType = 0
    @State private var milestoneArray: [TrackingType] = []
    
    //Sheet
    @State private var addActivityType = false
    
    //Alerts
    @State private var cantTitleEmpty = false
    
    func trackingTypeNamesToString(trackingTypeArray: [TrackingType]) -> [String]{
        var stringArray: [String] = []
        for type in trackingTypeArray {
            stringArray.append("\(type.value)")
        }
        return stringArray
    }
    
    func trackingTypeColorsToString(trackingTypeArray: [TrackingType]) -> [Color]{
        var colorArray: [Color] = []
        for type in trackingTypeArray {
            colorArray.append(type.color)
        }
        return colorArray
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Activity Name", text: $title)
                    TextField("Activity Description", text: $description)
                }
                Section{
                    DropdownPickerView(title: "Activity Type",
                                       selection: $activityType,
                                       options: habits.activityTypesToString(),
                                       deletingButton: true,
                                       verticalDirection: true,
                                       isColorful: true,
                                       colors: habits.activityTypeColorsToString(),
                                       addButtonText: "Add New Activity",
                                       addButtonSelect: $addActivityType)
                        .alert(isPresented: $cantTitleEmpty) {
                            Alert(title: Text("Title should be set"), message: Text("Title can not be empty"), dismissButton: .default(Text("Try Again")))
                        }
                        
                    DropdownPickerView(title: "Tracking Type", selection: $trackingType, options: habits.trackingTypes, deletingButton: false, verticalDirection: false)
                        .onChange(of: trackingType, perform: { value in
                            self.milestoneType = 0
                            if value == 0 {
                                
                                self.milestoneArray = habits.minuteTypes
                            }
                            else{
                                self.milestoneArray = habits.numberOfTimeTypes
                            }
                        })
                    
                    DropdownPickerView(title: "Routine Type", selection: $routineType, options: habits.routineTypes, deletingButton: false, verticalDirection: false)
                    
                    
                    DropdownPickerView(title: "Activity Goal",
                       selection: $milestoneType,
                       options: self.trackingTypeNamesToString(trackingTypeArray: milestoneArray),
                       deletingButton: false,
                       verticalDirection: false,
                       isColorful: true,
                       colors: self.trackingTypeColorsToString(trackingTypeArray: milestoneArray))
                        
                }
            }
            .onAppear{self.milestoneArray = habits.minuteTypes}
            .sheet(isPresented: $addActivityType) {AddActivityTypeView()}
            .navigationBarTitle("Add New Activity 🔥")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        //Title should be set
                        if self.title.count > 0 {
                            title = self.title
                            let activity = Activity(title: self.title,
                            description: self.description,
                            startDate: Date(),
                            activityType: habits.activityTypes[activityType],
                            trackingType: habits.trackingTypes[trackingType],
                            routine: habits.routineTypes[routineType],
                            milestone: self.milestoneArray[milestoneType],
                            userNotes: [])
                            self.habits.activities.append(activity)
                            self.presentationMode.wrappedValue.dismiss()
                        }else { cantTitleEmpty = true }
                    
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
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}
