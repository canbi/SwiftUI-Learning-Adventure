//
//  Activity.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//  Updated by Can Bi on 06.02.2022.
//

import Foundation
import SwiftUI

struct Activity: Codable, Identifiable{
    var id = UUID()
    var title: String
    var description: String
    let startDate: Date
    var activityType: ActivityType //runnning, jogging, swimming, reading...
    var trackingType: String //tracking total time, tracking number of times
    var routine: String //Daily, 2day, 3day, weekly, monthly, yearly
    var milestone: TrackingType //user activity goal
    var userNotes: [String]
    var goalProgress: Int {
        let progress = 37
        return progress
    }
    
    mutating func appendNote(newNote: String){
        self.userNotes.append(newNote)
    }
}
