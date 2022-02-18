//
//  Person+CoreDataProperties.swift
//  SomeoneNew
//
//  Created by Can Bi on 18.02.2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var photoName: String?
    
    var wrappedName: String {
        name ?? "Unknown"
    }

    var wrappedDesc: String {
        desc ?? "No Description"
    }
    
    var wrappedPhotoName: String {
        photoName ?? "no_photo"
    }
}

extension Person : Identifiable {

}
