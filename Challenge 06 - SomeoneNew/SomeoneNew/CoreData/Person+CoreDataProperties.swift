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

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var photoName: String?
    @NSManaged public var latitude: Double?
    @NSManaged public var longitude: Double?
    
    
    var wrappedName: String {
        name ?? "Unknown"
    }

    var wrappedDesc: String {
        desc ?? "No Description"
    }
    
    var wrappedPhotoName: String {
        photoName ?? "no_photo"
    }
    
    var wrappedLatitude: Double {
        latitude ?? 41.0082
    }
    
    var wrappedLongitude: Double {
        longitude ?? 28.9784
    }

}

extension Person : Identifiable {

}
