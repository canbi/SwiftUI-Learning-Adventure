//
//  TrackingType.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import Foundation
import SwiftUI


struct TrackingType: Codable{
    let value: String
    let color: Color
    
    init(_ value: String, _ color: Color) {
        self.value = value
        self.color = color
    }
}
