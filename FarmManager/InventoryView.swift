import SwiftUI
import CoreData

struct InventoryView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        entity: InventoryItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \InventoryItem.createdAt, ascending: false)]
    ) private var items: FetchedResults<InventoryItem>

    @State private var showingAddItem = false

    var body: some View {
        
        List {
            ForEach(items) { item in
                VStack(alignment: .leading) {
                    Text(item.name ?? "Unnamed Item")
                        .font(.headline)
                    Text("Quantity: \(item.quantity, specifier: "%.2f") \(item.unit ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if let category = item.category {
                        Text("Category: \(category)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Inventory")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddItem = true }) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        .sheet(isPresented: $showingAddItem) {
            NavigationView {
                AddInventoryItemView()
                    .environment(\.managedObjectContext, context)
            }
        }
    
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            context.delete(items[index])
        }
        try? context.save()
    }
}
