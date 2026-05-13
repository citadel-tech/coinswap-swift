import SwiftUI
import Coinswap

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Coinswap iOS Starter")
                .font(.title2)
                .bold()

            Text("Connect your RPC + Tor config, then wire up the taker flows.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            Button("Add Wallet Config") {}
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
