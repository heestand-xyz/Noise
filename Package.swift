// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Noise",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "Noise",
            targets: ["Noise"]),
    ],
    dependencies: [
        .package(url: "https://github.com/heestand-xyz/PixelKit", .exact("2.0.4")),
    ],
    targets: [
        .target(
            name: "Noise",
            dependencies: ["PixelKit"]),
    ]
)
