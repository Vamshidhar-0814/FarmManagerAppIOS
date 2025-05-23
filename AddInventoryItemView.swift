import SwiftUI
import CoreData

struct AddInventoryItemView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var quantity: Double = 0
    @State private var unit = ""
    @State private var category = ""
    @State private var notes = ""

    var body: some View {
        Form {
            Section(header: Text("Item Info")) {
                TextField("Name", text: $name)
                TextField("Quantity", value: $quantity, format: .number)
                TextField("Unit (e.g., kg)", text: $unit)
                TextField("Category (optional)", text: $category)
                TextField("Notes (optional)", text: $notes)
            }

            Button("Save") {
                let item = InventoryItem(context: context)
                item.id = UUID()
                item.name = name
                item.quantity = quantity
                item.unit = unit
                item.category = category
                item.notes = notes
                item.createdAt = Date()

                try? context.save()
                dismiss()
            }
            .disabled(name.isEmpty || quantity <= 0)
        }
        .navigationTitle("Add Inventory Item")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
        }
    }
}
