//
//  User.swift
//  FakeBook
//
//  Created by Can Bi on 9.02.2022.
//

import Foundation
import SwiftUI

struct User: Identifiable, Codable{
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
