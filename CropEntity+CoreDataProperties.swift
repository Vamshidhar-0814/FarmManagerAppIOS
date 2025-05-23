//
//  CropEntity+CoreDataProperties.swift
//  FarmManager
//
//  Created by Vamshidhar Reddy on 22/05/25.
//
//

import Foundation
import CoreData


extension CropEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CropEntity> {
        return NSFetchRequest<CropEntity>(entityName: "CropEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var variety: String?
    @NSManaged public var field: FieldEntity?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension CropEntity {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskEntity)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskEntity)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension CropEntity : Identifiable {

}
