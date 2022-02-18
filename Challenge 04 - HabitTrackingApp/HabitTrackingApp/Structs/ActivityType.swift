//
//  ActivityType.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 21.07.2021.
//  Updated by Can Bi on 06.02.2022.
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
