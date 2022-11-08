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
    dependencies: [
        .package(url:"https://github.com/ra1028/DifferenceKit.git", from: .init(stringLiteral: "1.3.0"))
    ],
    targets: [
        .target(
            name: "CoreTableView",
            dependencies: [
                .product(name: "DifferenceKit", package: "DifferenceKit")
            ]),
        .testTarget(
            name: "CoreTableViewTests",
            dependencies: ["CoreTableView"]),
    ]
)
