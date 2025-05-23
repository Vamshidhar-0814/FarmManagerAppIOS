import SwiftUI
import Foundation

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var farmStore: FarmStore

    @FetchRequest(
        entity: FarmEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FarmEntity.name, ascending: true)]
    ) private var farms: FetchedResults<FarmEntity>

    @State private var showingAddFarm = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: - Header
                HStack {
                    Text("🌾 Dashboard")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Menu {
                        ForEach(farms) { farm in
                            Button(action: {
                                farmStore.selectedFarm = farm
                            }) {
                                Text(farm.name ?? "Unnamed")
                            }
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "leaf.circle.fill")
                                .foregroundColor(.green)
                            Text(farmStore.selectedFarm?.name ?? "Select Farm")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Image(systemName: "chevron.down")
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal)

                // MARK: - Farm Card
                if let farm = farmStore.selectedFarm {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome to")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(farm.name ?? "Unnamed Farm")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            Button(action: {
                                showingAddFarm = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            .accessibilityLabel("Add Farm")
                        }

                        Divider()

                        // Stat Cards
                        HStack(spacing: 16) {
                            StatCard(title: "Fields", count: farm.fieldsArray.count, color: .blue, systemImage: "square.grid.2x2.fill")
                            StatCard(title: "Crops", count: farm.fieldsArray.flatMap { $0.cropsArray }.count, color: .orange, systemImage: "leaf.fill")
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
                    .padding(.horizontal)
                } else {
                    // MARK: - Empty State
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 48))
                        Text("No Farm Selected")
                            .font(.headline)
                        Text("Choose or add a farm using the menu above.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal)
                }

                Spacer(minLength: 32)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddFarm) {
            NavigationView {
                AddFarmView()
                    .environmentObject(farmStore)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
        .onAppear {
            if farmStore.selectedFarm == nil {
                farmStore.selectedFarm = farms.first
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let count: Int
    let color: Color
    let systemImage: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundColor(.white)
                .padding(10)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("\(count)")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
}
