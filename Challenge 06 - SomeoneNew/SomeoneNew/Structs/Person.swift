//
//  Person.swift
//  SomeoneNew
//
//  Created by Can Bi on 15.02.2022.
//

import Foundation

struct Person: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var photoName: String
}
