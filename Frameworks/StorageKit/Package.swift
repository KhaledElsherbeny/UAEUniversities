// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StorageKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "StorageKit",
            targets: ["StorageKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-cocoa.git", .upToNextMajor(from: "10.50.0"))
    ],
    targets: [
        .target(
            name: "StorageKit",
            dependencies: [.product(name: "RealmSwift", package: "realm-cocoa")]),
        .testTarget(
            name: "StorageKitTests",
            dependencies: ["StorageKit"]),
    ]
)

