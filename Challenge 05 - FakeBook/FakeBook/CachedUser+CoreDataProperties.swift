//
//  CachedUser+CoreDataProperties.swift
//  FakeBook
//
//  Created by Can Bi on 11.02.2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown User"
    }
    
    public var wrappedCompany: String {
        company ?? "No company Info"
    }
    
    public var wrappedEmail: String {
        email ?? "No email info"
    }
    
    public var wrappedAddress: String {
        address ?? "No address info"
    }
    
    public var wrappedAbout: String {
        about ?? "No about"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var wrappedTags: String {
        tags ?? "No tag"
    }
    
    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
