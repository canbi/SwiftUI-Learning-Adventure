//
//  CachedFriend+CoreDataProperties.swift
//  FakeBook
//
//  Created by Can Bi on 11.02.2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension CachedFriend : Identifiable {

}
