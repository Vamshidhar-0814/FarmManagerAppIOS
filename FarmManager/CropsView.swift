import SwiftUI
import CoreData

struct CropsView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var farmStore: FarmStore
    
    @FetchRequest private var crops: FetchedResults<CropEntity>
    
    // Custom initializer to fetch crops linked to selectedFarm
    init(selectedFarm: FarmEntity?) {
        if let farm = selectedFarm {
            _crops = FetchRequest<CropEntity>(
                entity: CropEntity.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \CropEntity.name, ascending: true)],
                predicate: NSPredicate(format: "field.farm == %@", farm)
            )
        } else {
            // No farm selected, fetch no crops
            _crops = FetchRequest<CropEntity>(
                entity: CropEntity.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(value: false)
            )
        }
    }
    
    var body: some View {
        Group {
            if let farm = farmStore.selectedFarm {
                if crops.isEmpty {
                    Text("No crops found in \(farm.name ?? "this farm").")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        Section(header: Text("Crops for \(farm.name ?? "this farm")")) {
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
                    }
                }
            } else {
                Text("No farm selected")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationTitle("Crops")
    }
    
    private func deleteCrop(at offsets: IndexSet) {
        for index in offsets {
            context.delete(crops[index])
        }
        do {
            try context.save()
        } catch {
            print("❌ Failed to delete crop: \(error)")
        }
    }
}
