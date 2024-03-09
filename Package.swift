// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OllamaKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "OllamaKit",
            targets: ["OllamaKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.1")),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/realm/SwiftLint.git", .upToNextMajor(from: "0.54.0"))
    ],
    targets: [
        .target(
            name: "OllamaKit",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "OllamaKitTests",
            dependencies: ["OllamaKit", "Alamofire"]),
    ]
)
