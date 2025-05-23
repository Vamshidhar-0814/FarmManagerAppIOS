import SwiftUI
import CoreData

struct FieldsView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var farmStore: FarmStore
    @State private var showingAddField = false

    @FetchRequest private var fields: FetchedResults<FieldEntity>

    init(selectedFarm: FarmEntity?) {
        if let farm = selectedFarm {
            _fields = FetchRequest<FieldEntity>(
                entity: FieldEntity.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \FieldEntity.name, ascending: true)],
                predicate: NSPredicate(format: "farm == %@", farm)
            )
        } else {
            _fields = FetchRequest<FieldEntity>(
                entity: FieldEntity.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(value: false)
            )
        }
    }

    var body: some View {
        List {
            if let farm = farmStore.selectedFarm {
                if fields.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "rectangle.on.rectangle.slash")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("No fields added yet")
                            .font(.headline)
                        Text("Tap the + button to add a new field to \(farm.name ?? "your farm").")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .padding(.vertical)
                } else {
                    Section(header: Text("Fields in \(farm.name ?? "Farm")")) {
                        ForEach(fields) { field in
                            NavigationLink(destination:
                                FieldDetailView(field: field)) {
                                FieldRowView(field: field)
                            }
                        }
                        .onDelete(perform: deleteField)
                    }
                }
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("No Farm Selected")
                        .font(.headline)
                    Text("Please select a farm to view its fields.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Fields")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddField = true
                } label: {
                    Label("Add Field", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddField) {
            NavigationView {
                AddFieldView(selectedFarm: farmStore.selectedFarm)
                    .environment(\.managedObjectContext, context)
                    .environmentObject(farmStore)
            }
        }
    }

    private func deleteField(at offsets: IndexSet) {
        for index in offsets {
            let field = fields[index]
            context.delete(field)
        }

        do {
            try context.save()
        } catch {
            print("❌ Failed to delete field: \(error.localizedDescription)")
        }
    }
}

struct FieldRowView: View {
    let field: FieldEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(field.name ?? "Unnamed Field")
                .font(.headline)
            Text("\(field.cropsArray.count) crop\(field.cropsArray.count == 1 ? "" : "s")")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 6)
    }
}
