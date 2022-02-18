//
//  ContentView.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//  Updated by Can Bi on 06.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddActivity = false
    
    @State private var selectedActivity: Activity?
    
    var body: some View {
        NavigationView {
            List{
                ForEach(Array(zip(habits.activities.indices, habits.activities)), id: \.0) { index, activity in
                    VStack(alignment: .leading, spacing: 10){
                        ActivityTypeCapsule(activity: activity)
                        Text(activity.title)
                    }
                    .onTapGesture {
                        selectedActivity = activity
                    }.padding(.vertical)
                }

                .onDelete(perform: removeItems)
                .onMove(perform: move)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .navigationBarTitle("Habit-Tracking App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.showingAddActivity = true},
                           label: {
                        HStack {
                            Image(systemName: "plus.square.fill")
                            Text("Add activity")
                        }
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView()
            }
            .sheet(item: $selectedActivity, onDismiss: {
                self.selectedActivity = nil
            }) {
                ActivityDetails(activity: $0)
            }
        }
        .environmentObject(habits)
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.activities.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        habits.activities.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
