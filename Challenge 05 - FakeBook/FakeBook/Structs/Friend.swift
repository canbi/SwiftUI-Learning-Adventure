//
//  Friend.swift
//  FakeBook
//
//  Created by Can Bi on 9.02.2022.
//

import Foundation
import SwiftUI

struct Friend: Identifiable, Codable, Hashable{
    var id: UUID
    var name: String
}
