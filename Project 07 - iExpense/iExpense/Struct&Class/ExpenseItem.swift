//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Can Bi on 2.02.2022.
//

import Foundation

enum ExpenseType: String, CaseIterable, Identifiable, Codable {
    case Personal = "Personal"
    case Business = "Business"
    
    var id: ExpenseType { self }
}

struct ExpenseItem:Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}
