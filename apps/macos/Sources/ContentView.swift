import SwiftUI
import Coinswap

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Coinswap macOS Starter")
                .font(.title2)
                .bold()

            Text("Point this app at your Coinswap backend to begin.")
                .font(.footnote)
                .foregroundColor(.secondary)

            Divider()

            Text("Next steps:")
                .font(.headline)
            Text("1. Configure RPC + Tor settings")
            Text("2. Initialize a taker wallet")
            Text("3. Sync offer book")
        }
        .padding(24)
    }
}
