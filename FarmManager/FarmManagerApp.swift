import SwiftUI
import Foundation

@main
struct FarmApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        let context = persistenceController.container.viewContext
        let farmStore = FarmStore(context: context)

        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, context)
                .environmentObject(farmStore) // ✅ Inject into environment
        }
    }
}
