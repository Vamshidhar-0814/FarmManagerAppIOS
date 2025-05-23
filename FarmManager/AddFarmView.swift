import SwiftUI
import CoreData

struct AddFarmView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var farmStore: FarmStore // for selectedFarm tracking if still used
    @Environment(\.dismiss) private var dismiss

    @State private var farmName = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Farm Name", text: $farmName)
            }
            .navigationTitle("Add Farm")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addFarm()
                        dismiss()
                    }
                    .disabled(farmName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func addFarm() {
        let newFarm = FarmEntity(context: context)
        newFarm.name = farmName
        newFarm.id = UUID()

        do {
            try context.save()
            farmStore.selectedFarm = newFarm
        } catch {
            print("❌ Failed to save farm: \(error.localizedDescription)")
        }
    }
}
