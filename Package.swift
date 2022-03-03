// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreTableView",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "CoreTableView",
            targets: ["CoreTableView"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "CoreTableView",
            dependencies: []),
        .testTarget(
            name: "CoreTableViewTests",
            dependencies: ["CoreTableView"]),
    ]
)
