//
//  FilteredView.swift
//  CoreDataProject
//
//  Created by Can Bi on 8.02.2022.
//

import CoreData
import SwiftUI

enum PredicateFilters: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case beginsWithInCase = "BEGINSWITH[c]"
    case containsInCase = "CONTAINS[c]"
    case like = "LIKE"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, filter: PredicateFilters, sortDescriptors: [NSSortDescriptor] ,@ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filter.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
