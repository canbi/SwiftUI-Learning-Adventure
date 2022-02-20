//
//  Card.swift
//  Flashzilla
//
//  Created by Can Bi on 20.02.2022.
//

import Foundation

struct Card: Codable, Identifiable {
    var id: UUID
    let prompt: String
    let answer: String
    
    static let example = Card(id: UUID(),
                              prompt: "Who played the 13th Doctor in Doctor Who?",
                              answer: "Jodie Whittaker")
}
