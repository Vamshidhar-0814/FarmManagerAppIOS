import SwiftUI
import CoreData

struct ExpenseView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        entity: ExpenseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseEntity.date, ascending: false)]
    ) private var expenses: FetchedResults<ExpenseEntity>

    @State private var showingAddExpense = false

    var body: some View {
    
        List {
            ForEach(expenses) { expense in
                VStack(alignment: .leading) {
                    Text(expense.title ?? "Untitled Expense")
                        .font(.headline)
                    Text("₹\(expense.amount, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    if let category = expense.category {
                        Text(category)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    if let date = expense.date {
                        Text(date.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .onDelete(perform: deleteExpenses)
        }
        .navigationTitle("Expenses")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddExpense = true }) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            NavigationView {
                AddExpenseView()
                    .environment(\.managedObjectContext, context)
            }
        }
    }

    private func deleteExpenses(at offsets: IndexSet) {
        for index in offsets {
            context.delete(expenses[index])
        }
        try? context.save()
    }
}
