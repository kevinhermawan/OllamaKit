// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OllamaKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "OllamaKit",
            targets: ["OllamaKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin.git", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/1amageek/swift-json-schema.git", branch: "main")
    ],
    targets: [
        .target(
            name: "OllamaKit",
            dependencies: [
                .product(name: "JSONSchema", package: "swift-json-schema")
            ]),
        .testTarget(
            name: "OllamaKitTests",
            dependencies: ["OllamaKit"]),
    ]
)
