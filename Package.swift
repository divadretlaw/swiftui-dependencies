// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI Dependencies",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]
        )
    ],
    targets: [
        .target(name: "Dependencies"),
        .testTarget(
            name: "DependenciesTests",
            dependencies: ["Dependencies"]
        )
    ]
)
