import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var farmStore: FarmStore
    @Environment(\.managedObjectContext) var context 

    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Dashboard", systemImage: "house")
            }

            NavigationStack {
                FieldsView(selectedFarm: farmStore.selectedFarm)
                    .environment(\.managedObjectContext, context)
                    .environmentObject(farmStore)
            }
            .tabItem {
                Label("Fields", systemImage: "square.3.stack.3d.top.fill")
            }

            NavigationStack {
                CropsView(selectedFarm: farmStore.selectedFarm)
                    .environment(\.managedObjectContext, context)
                    .environmentObject(farmStore)
            }
            .tabItem {
                Label("Crops", systemImage: "leaf")
            }

            NavigationStack {
                TasksView()
            }
            .tabItem {
                Label("Tasks", systemImage: "checkmark.circle")
            }

            NavigationStack {
                InventoryView()
            }
            .tabItem {
                Label("Inventory", systemImage: "tray.full")
            }
            
            NavigationStack {
                ExpenseView()
            }
            .tabItem {
                Label("Expense", systemImage: "tray.full")
            }


            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.shared.container.viewContext
        let store = FarmStore(context: previewContext)

        return MainTabView()
            .environment(\.managedObjectContext, previewContext)
            .environmentObject(store)
    }
}
