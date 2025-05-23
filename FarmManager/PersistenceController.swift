import Foundation
import SwiftUI
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        let viewContext = controller.container.viewContext

        // Create mock data for preview
        let farm = FarmEntity(context: viewContext)
        farm.id = UUID()
        farm.name = "Preview Farm"

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FarmModel") // must match your .xcdatamodeld file
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("❌ Core Data store failed: \(error)")
            }
        }
    }
}
