//
//  ExpenseEntity+CoreDataProperties.swift
//  FarmManager
//
//  Created by Vamshidhar Reddy on 22/05/25.
//
//

import Foundation
import CoreData


extension ExpenseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        return NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var category: String?
    @NSManaged public var notes: String?
    @NSManaged public var farm: FarmEntity?
    @NSManaged public var field: FieldEntity?
    @NSManaged public var crop: CropEntity?

}

extension ExpenseEntity : Identifiable {

}
