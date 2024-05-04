// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UniversitiesList",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "UniversitiesList",
            targets: ["UniversitiesList"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../Frameworks/NetworkKit"),
        .package(path: "../Frameworks/StorageKit"),
        .package(path: "../Frameworks/UtilitiesKit"),
    ],
    targets: [
        .target(
            name: "UniversitiesList",
            dependencies: ["NetworkKit", "StorageKit", "UtilitiesKit"]),
        .testTarget(
            name: "UniversitiesListTests",
            dependencies: ["UniversitiesList"]),
    ]
)

