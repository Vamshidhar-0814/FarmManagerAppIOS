//
//  TaskEntity+CoreDataProperties.swift
//  FarmManager
//
//  Created by Vamshidhar Reddy on 22/05/25.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var notes: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var crop: CropEntity?
    @NSManaged public var field: FieldEntity?

}

extension TaskEntity : Identifiable {

}
