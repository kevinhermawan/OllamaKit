// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OllamaKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "OllamaKit",
            targets: ["OllamaKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.1")),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", .upToNextMajor(from: "1.3.0"))
    ],
    targets: [
        .target(
            name: "OllamaKit",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "OllamaKitTests",
            dependencies: ["OllamaKit", "Alamofire"]),
    ]
)
