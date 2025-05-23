import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var farmStore: FarmStore

    var body: some View {
        Group {
            if let farm = farmStore.selectedFarm {
                VStack {
                    Text("Settings for \(farm.name)")
                        .font(.title2)
                    // TODO: Show actual settings for this farm
                }
            } else {
                Text("No farm selected")
                    .foregroundStyle(.red)
            }
        }
        .navigationTitle("Settings")
    }
}
