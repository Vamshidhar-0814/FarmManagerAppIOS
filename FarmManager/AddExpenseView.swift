import SwiftUI

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var amount: Double = 0
    @State private var category = ""
    @State private var notes = ""
    @State private var date = Date()

    var body: some View {
        Form {
            Section(header: Text("Expense Details")) {
                TextField("Title", text: $title)
                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Category (optional)", text: $category)
                TextField("Notes (optional)", text: $notes)
            }

            Button("Save") {
                let expense = ExpenseEntity(context: context)
                expense.id = UUID()
                expense.title = title
                expense.amount = amount
                expense.date = date
                expense.category = category
                expense.notes = notes

                try? context.save()
                dismiss()
            }
            .disabled(title.isEmpty || amount <= 0)
        }
        .navigationTitle("Add Expense")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
        }
    }
}
