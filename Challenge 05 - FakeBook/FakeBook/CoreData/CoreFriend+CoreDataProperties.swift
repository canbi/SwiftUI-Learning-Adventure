//
//  CoreFriend+CoreDataProperties.swift
//  FakeBook
//
//  Created by Can Bi on 11.02.2022.
//
//

import Foundation
import CoreData


extension CoreFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreFriend> {
        return NSFetchRequest<CoreFriend>(entityName: "CoreFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown User"
    }
}

extension CoreFriend : Identifiable {

}
