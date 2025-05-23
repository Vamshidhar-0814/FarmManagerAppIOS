//
//  InventoryItem+CoreDataProperties.swift
//  FarmManager
//
//  Created by Vamshidhar Reddy on 22/05/25.
//
//

import Foundation
import CoreData


extension InventoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InventoryItem> {
        return NSFetchRequest<InventoryItem>(entityName: "InventoryItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Double
    @NSManaged public var unit: String?
    @NSManaged public var category: String?
    @NSManaged public var notes: String?
    @NSManaged public var createdAt: Date?

}

extension InventoryItem : Identifiable {

}
