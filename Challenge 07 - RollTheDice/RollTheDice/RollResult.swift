//
//  RollResult.swift
//  RollTheDice
//
//  Created by Can Bi on 21.02.2022.
//

import SwiftUI

enum DiceKind: Int, Codable, CaseIterable, Identifiable {
    case side4 = 4
    case side6 = 6
    case side7 = 7
    case side8 = 8
    case side10 = 10
    case side12 = 12
    case side20 = 20
    case side48 = 48
    case side100 = 100
    
    var id: DiceKind { self }
}

struct RollResult: Codable, Identifiable {
    var id: UUID
    var date: Date
    var dice: DiceKind
    var result: Int
    
    static let example = RollResult(id: UUID(), date: Date.now, dice: DiceKind.side6, result: 4)
}
