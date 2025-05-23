import CoreData
import SwiftUI
import Foundation

class FarmStore: ObservableObject {
    private var context: NSManagedObjectContext

    @Published var selectedFarm: FarmEntity?
    @Published var selectedFarmID: UUID? {
        didSet {
            if let id = selectedFarmID {
                selectedFarm = farms.first(where: { $0.id == id })
            } else {
                selectedFarm = nil
            }
        }
    }

    @Published var farms: [FarmEntity] = []

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchFarms()
    }

    func fetchFarms() {
        let request: NSFetchRequest<FarmEntity> = FarmEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FarmEntity.createdAt, ascending: true)]

        do {
            farms = try context.fetch(request)
            selectedFarmID = farms.first?.id
        } catch {
            print("❌ Failed to fetch farms: \(error)")
        }
    }

    func addFarm(name: String) {
        let newFarm = FarmEntity(context: context)
        newFarm.id = UUID()
        newFarm.name = name
        newFarm.createdAt = Date()

        save()
        fetchFarms()
    }

    func deleteFarm(_ farm: FarmEntity) {
        context.delete(farm)
        save()
        fetchFarms()
    }

    func save() {
        do {
            try context.save()
        } catch {
            print("❌ Failed to save: \(error)")
        }
    }
}
