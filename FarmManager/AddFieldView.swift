import SwiftUI

struct AddFieldView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    var selectedFarm: FarmEntity?

    @State private var fieldName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Field Name")) {
                    TextField("Enter field name", text: $fieldName)
                }

                Button("Save") {
                    addField()
                }
                .disabled(fieldName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .navigationTitle("Add Field")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func addField() {
        guard let farm = selectedFarm else { return }

        let newField = FieldEntity(context: context)
        newField.id = UUID()
        newField.name = fieldName
//        newField.createdAt = Date()
        newField.farm = farm

        do {
            try context.save()
            dismiss()
        } catch {
            print("❌ Failed to save field: \(error.localizedDescription)")
        }
    }
}
