//
//  ContentView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
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

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddActivity = false
    
    func removeItems(at offsets: IndexSet) {
        habits.activities.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        habits.activities.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(habits.activities) { activity in
                    VStack(spacing:0){
                        HStack(alignment: .top){
                            
                            VStack(alignment: .leading, spacing: 10){
                                //ACTIVITY TYPE CAPSULE
                                activityTypeCapsule(activity: activity)
                                
                                //ACTIVITY NAME
                                Text(activity.title)
                            }
                            /*
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                
                                
                            }*/
                        }
                    }
                }
                .onDelete(perform: removeItems)
                .onMove(perform: move)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
            .background(Color.white)
            .navigationBarTitle("Habit-Tracking App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingAddActivity = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showingAddActivity) {
            AddActivityView()
        }
        .environmentObject(habits)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct activityTypeCapsule: View {
    let activity: Activity
    
    var body: some View {
        ZStack{
            
            //ACTIVITY TYPE NAME
            HStack(alignment: .top){
                Text("\(activity.activityType.name)")
                    .bold()
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(EdgeInsets.init(top: 4, leading: 45, bottom: 4, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 15).fill(activity.activityType.color))
                Spacer()
                
                VStack(alignment: .trailing){
                    //ROUTINE TYPE
                    Text(activity.routine)
                        .capsuleTextStyle()
                    
                    //ACTIVITY GOAL
                    Text(activity.milestone.value)
                        .capsuleTextStyle(color: activity.milestone.color)
                }
                
                
            }
            //EMOJİ
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Text(activity.activityType.emoji)
                        .font(.system(size: 36))
                    //.font(.largeTitle)
                    Spacer()
                }
                Spacer()
            }
            
        }
    }
}
