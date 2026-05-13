// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "CoinswapMacApp",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "CoinswapMacApp",
            targets: ["CoinswapMacApp"]
        )
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .executableTarget(
            name: "CoinswapMacApp",
            dependencies: [
                .product(name: "Coinswap", package: "Coinswap")
            ],
            path: "Sources"
        )
    ]
)
