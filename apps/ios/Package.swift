// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "CoinswapIOSApp",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .executable(
            name: "CoinswapIOSApp",
            targets: ["CoinswapIOSApp"]
        )
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .executableTarget(
            name: "CoinswapIOSApp",
            dependencies: [
                .product(name: "Coinswap", package: "Coinswap")
            ],
            path: "Sources"
        )
    ]
)
