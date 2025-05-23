//
//  CoreDataExtensions.swift
//  FarmManager
//
//  Created by Vamshidhar Reddy on 22/05/25.
//

import Foundation

extension FarmEntity {
    var fieldsArray: [FieldEntity] {
        let set = fields as? Set<FieldEntity> ?? []
        return set.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
}

extension FieldEntity {
    var cropsArray: [CropEntity] {
        let set = crops as? Set<CropEntity> ?? []
        return set.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
}

extension FieldEntity {
    var tasksArray: [TaskEntity] {
        (tasks as? Set<TaskEntity> ?? []).sorted { ($0.dueDate ?? Date.distantFuture) < ($1.dueDate ?? Date.distantFuture) }
    }
}

extension CropEntity {
    var tasksArray: [TaskEntity] {
        (tasks as? Set<TaskEntity> ?? []).sorted { ($0.dueDate ?? Date.distantFuture) < ($1.dueDate ?? Date.distantFuture) }
    }
}
