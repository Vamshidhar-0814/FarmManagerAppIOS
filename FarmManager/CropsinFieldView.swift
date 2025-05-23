import SwiftUI
import CoreData

struct CropsInFieldView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var farmStore: FarmStore

    let field: FieldEntity
    @State private var showingAddCrop = false

    // Use @FetchRequest to automatically observe changes to this field's crops
    @FetchRequest private var crops: FetchedResults<CropEntity>

    init(field: FieldEntity) {
        self.field = field
        _crops = FetchRequest<CropEntity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \CropEntity.name, ascending: true)],
            predicate: NSPredicate(format: "field == %@", field)
        )
    }

    var body: some View {
        Group {
            if !crops.isEmpty {
                List {
                    ForEach(crops) { crop in
                        VStack(alignment: .leading) {
                            Text(crop.name ?? "Unnamed Crop")
                                .font(.headline)
                            if let variety = crop.variety {
                                Text(variety)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: deleteCrop)
                }
            } else {
                VStack(spacing: 16) {
                    Spacer()
                    Image(systemName: "leaf")
                        .font(.system(size: 48))
                        .foregroundColor(.green)
                    Text("No crops in this field yet.")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Text("Tap the '+' button to add your first crop.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(field.name ?? "Field")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddCrop = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddCrop) {
            AddCropView(field: field)
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(farmStore)
        }
    }

    private func deleteCrop(at offsets: IndexSet) {
        for index in offsets {
            viewContext.delete(crops[index])
        }
        do {
            try viewContext.save()
        } catch {
            print("❌ Failed to delete crop: \(error)")
        }
    }
}
