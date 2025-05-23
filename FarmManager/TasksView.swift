import SwiftUI
import CoreData

struct TasksView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        entity: TaskEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.dueDate, ascending: true)],
        predicate: nil
    ) private var tasks: FetchedResults<TaskEntity>

    @State private var showingAddTask = false

    var body: some View {
         
        List {
            ForEach(tasks) { task in
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.title ?? "Untitled Task")
                            .font(.headline)

                        if let due = task.dueDate {
                            Text("Due: \(due.formatted(date: .abbreviated, time: .omitted))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        if let field = task.field {
                            Text("Field: \(field.name ?? "Unknown")")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }

                        if let crop = task.crop {
                            Text("Crop: \(crop.name ?? "Unknown")")
                                .font(.caption2)
                                .foregroundColor(.green)
                        }
                    }

                    Spacer()

                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                        .onTapGesture {
                            task.isCompleted.toggle()
                            try? context.save()
                        }
                }
            }
            .onDelete(perform: deleteTasks)
        }
        .navigationTitle("All Tasks")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddTask = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        
        .sheet(isPresented: $showingAddTask) {
            NavigationView {
                AddTaskView()
                    .environment(\.managedObjectContext, context)
            }
        }
    }

    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            context.delete(tasks[index])
        }
        try? context.save()
    }
}
