//
//  ActivityType.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//

import Foundation
import SwiftUI

struct ActivityType: Codable{
    let emoji: String
    let name: String
    let color: Color
    
    init(_ typeEmoji: String, _ typeName: String, _ typeColor: Color) {
        self.emoji = typeEmoji
        self.name = typeName
        self.color = typeColor
    }
    
}

struct TrackingType: Codable{
    let value: String
    let color: Color
    
    init(_ value: String, _ color: Color) {
        self.value = value
        self.color = color
    }
}
