import SwiftUI

struct FieldDetailView: View {
    @Environment(\.managedObjectContext) private var context
    let field: FieldEntity
    @State private var showingAddCrop = false

    var body: some View {
        List {
            Section(header: Text("Field Information")) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(field.name ?? "Unnamed Field")
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("Crops")) {
                if field.cropsArray.isEmpty {
                    Text("No crops added yet.")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)
                } else {
                    ForEach(field.cropsArray, id: \.self) { crop in
                        HStack {
                            Image(systemName: "leaf")
                                .foregroundColor(.green)
                            VStack(alignment: .leading) {
                                Text(crop.name ?? "Unnamed Crop")
                                    .font(.body)
                                if let variety = crop.variety, !variety.isEmpty {
                                    Text(variety)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    // Optional: Enable deleting crops
                    // .onDelete(perform: deleteCrop)
                }
            }
        }
        .navigationTitle(field.name ?? "Field Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    showingAddCrop = true
                } label: {
                    Label("Add Crop", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddCrop) {
            AddCropView(field: field)
                .environment(\.managedObjectContext, context)

        }
    }

    // Optional for future: deleting crops
    /*
    private func deleteCrop(at offsets: IndexSet) {
        for index in offsets {
            let crop = field.cropsArray[index]
            context.delete(crop)
        }

        do {
            try context.save()
        } catch {
            print("❌ Failed to delete crop: \(error.localizedDescription)")
        }
    }
    */
}
