//
//  FieldEntity+CoreDataProperties.swift
//  FarmManager
//
//  Created by Vamshidhar Reddy on 22/05/25.
//
//

import Foundation
import CoreData


extension FieldEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FieldEntity> {
        return NSFetchRequest<FieldEntity>(entityName: "FieldEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var crops: NSSet?
    @NSManaged public var farm: FarmEntity?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for crops
extension FieldEntity {

    @objc(addCropsObject:)
    @NSManaged public func addToCrops(_ value: CropEntity)

    @objc(removeCropsObject:)
    @NSManaged public func removeFromCrops(_ value: CropEntity)

    @objc(addCrops:)
    @NSManaged public func addToCrops(_ values: NSSet)

    @objc(removeCrops:)
    @NSManaged public func removeFromCrops(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension FieldEntity {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskEntity)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskEntity)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension FieldEntity : Identifiable {

}
