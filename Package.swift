// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Spiral",
    platforms: [
        .macOS(.v11), .iOS(.v14), .watchOS(.v7)
    ],
    products: [
        .library(
            name: "Spiral",
            targets: ["Spiral"]
        ),
    ],
    targets: [
        .target(
            name: "Spiral"
        ),
    ]
)
