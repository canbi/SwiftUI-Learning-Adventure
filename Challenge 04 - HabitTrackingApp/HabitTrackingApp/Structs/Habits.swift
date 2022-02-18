//
//  Habits.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//  Updated by Can Bi on 06.02.2022.
//

import Foundation
import SwiftUI

class Habits: ObservableObject{
    @Published var activities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
            else{
                fatalError("Failed to encode Activities to bundle.")
            }
        }
    }
    
    var trackingTypes = ["Time Tracking", "Number of Times"]
    var routineTypes = ["Daily", "Every Two Days", "Every Three Days", "Weekly", "Every Two Week", "Every Month", "Yearly"]
    var minuteTypes: [TrackingType] = [TrackingType("1 Minute",Color("ColorSet1")),
                                       TrackingType("2 Minute",Color("ColorSet2")),
                                       TrackingType("5 Minute",Color("ColorSet3")),
                                       TrackingType("10 Minute",Color("ColorSet4")),
                                       TrackingType("15 Minute",Color("ColorSet5")),
                                       TrackingType("30 Minute",Color("ColorSet6")),
                                       TrackingType("45 Minute",Color("ColorSet7")),
                                       TrackingType("60 Minute",Color("ColorSet8")),
                                       TrackingType("90 Minute",Color("ColorSet9")),
                                       TrackingType("120 Minute",Color("ColorSet10")),
                                       TrackingType("180 Minute",Color("ColorSet11")),
                                       TrackingType("240 Minute",Color("ColorSet1")),
                                       TrackingType("360 Minute",Color("ColorSet2")),
                                       TrackingType("480 Minute",Color("ColorSet3"))]
    
    var numberOfTimeTypes: [TrackingType] = [TrackingType("1 Time",Color("ColorSet1")),
                                             TrackingType("2 Times",Color("ColorSet2")),
                                             TrackingType("3 Times",Color("ColorSet3")),
                                             TrackingType("4 Times",Color("ColorSet4")),
                                             TrackingType("5 Times",Color("ColorSet5")),
                                             TrackingType("6 Times",Color("ColorSet6")),
                                             TrackingType("7 Times",Color("ColorSet7")),
                                             TrackingType("8 Times",Color("ColorSet8")),
                                             TrackingType("9 Times",Color("ColorSet9")),
                                             TrackingType("10 Times",Color("ColorSet10")),
                                             TrackingType("12 Times",Color("ColorSet11")),
                                             TrackingType("15 Times",Color("ColorSet1")),
                                             TrackingType("20 Times",Color("ColorSet2")),
                                             TrackingType("30 Times",Color("ColorSet3"))]
    
    @Published var activityTypes: [ActivityType] = []{
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activityTypes) {
                UserDefaults.standard.set(encoded, forKey: "ActivityTypes")
            }
            else{
                fatalError("Failed to encode ActivityTypes to bundle.")
            }
        }
    }
    
    init() {
        //Loading Activity Types
        if let activityTypes = UserDefaults.standard.data(forKey: "ActivityTypes") {
            let decoder = JSONDecoder()
            if let decodedTypes = try? decoder.decode([ActivityType].self, from: activityTypes) {
                self.activityTypes = decodedTypes
            }
            else{
                fatalError("Failed to decode ActivityType from bundle.")
            }
        }
        //FIRST OPEN
        else{
            self.activityTypes = [ActivityType("🚶🏻‍♂️", "Walk", Color("ColorSet1")),
                                  ActivityType("🏃🏻‍♂️", "Run", Color("ColorSet2")),
                                  ActivityType("🎙️", "Listen Podcast", Color("ColorSet3")),
                                  ActivityType("🎵", "Listen Music", Color("ColorSet4")),
                                  ActivityType("📕", "Read Book", Color("ColorSet5")),
                                  ActivityType("🎬", "Watch Movies", Color("ColorSet6")),
                                  ActivityType("📺", "Watch TV Series", Color("ColorSet7")),
                                  ActivityType("🎒", "Education", Color("ColorSet8")),
                                  ActivityType("🗣️", "Language Learning", Color("ColorSet9")),
                                  ActivityType("✍🏻", "Write a Blog", Color("ColorSet10")),
                                  ActivityType("🎹", "Play Enstrument", Color("ColorSet11")),
                                  ActivityType("🧘🏻‍♂️", "Meditation", Color("ColorSet1")),
                                  ActivityType("🥕", "Cooking", Color("ColorSet2"))]
        }
        
        //Loading Activities
        if let activities = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activities) {
                self.activities = decoded
            }
            else{
                fatalError("Failed to decode Activities from bundle.")
            }
        }
        else{
            self.activities = []
        }
        
    }
    
    func activityTypesToString() -> [String]{
        var stringArray: [String] = []
        for type in activityTypes {
            stringArray.append("\(type.emoji) \(type.name)")
        }
        return stringArray
    }
    
    func activityTypeColorsToString() -> [Color]{
        var colorArray: [Color] = []
        for type in activityTypes {
            colorArray.append(type.color)
        }
        return colorArray
    }
}
