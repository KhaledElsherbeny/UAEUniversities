// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UniversityDetails",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "UniversityDetails",
            targets: ["UniversityDetails"]
        ),
    ],
    dependencies: [
        .package(path: "../Modules/Domain"),
    ],
    targets: [
        .target(
            name: "UniversityDetails",
            dependencies: ["Domain"]
        ),
        .testTarget(
            name: "UniversityDetailsTests",
            dependencies: ["UniversityDetails"]
        ),
    ]
)
