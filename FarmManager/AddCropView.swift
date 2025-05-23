import SwiftUI

struct AddCropView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    let field: FieldEntity

    @State private var cropName = ""
    @State private var cropVariety = ""
    @State private var plantingDate = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Crop name", text: $cropName)
                TextField("Variety (optional)", text: $cropVariety)
                DatePicker("Planting Date", selection: $plantingDate, displayedComponents: .date)
            }
            .navigationTitle("Add Crop")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addCrop()
                        dismiss()
                    }
                    .disabled(cropName.isEmpty)
                }
            }
        }
    }

    private func addCrop() {
        let newCrop = CropEntity(context: context)
        newCrop.id = UUID()
        newCrop.name = cropName
        newCrop.variety = cropVariety.isEmpty ? nil : cropVariety
//        newCrop.plantingDate = plantingDate
        newCrop.field = field

        do {
            try context.save()
        } catch {
            print("❌ Failed to save crop: \(error)")
        }
    }
}
