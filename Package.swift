// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GrowingTextView",
    products: [
        .library(name: "GrowingTextView", targets: ["GrowingTextView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "GrowingTextView", dependencies: [])
    ]
)
