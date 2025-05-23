//
//  FarmEntity+CoreDataProperties.swift
//  FarmManager
//
//  Created by Vamshidhar Reddy on 21/05/25.
//
//

import Foundation
import CoreData


extension FarmEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FarmEntity> {
        return NSFetchRequest<FarmEntity>(entityName: "FarmEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var fields: NSSet?

}

// MARK: Generated accessors for fields
extension FarmEntity {

    @objc(addFieldsObject:)
    @NSManaged public func addToFields(_ value: FieldEntity)

    @objc(removeFieldsObject:)
    @NSManaged public func removeFromFields(_ value: FieldEntity)

    @objc(addFields:)
    @NSManaged public func addToFields(_ values: NSSet)

    @objc(removeFields:)
    @NSManaged public func removeFromFields(_ values: NSSet)

}

extension FarmEntity : Identifiable {

}
