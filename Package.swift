// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Genything",
    platforms: [
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v5),
        .macOS(.v10_14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Genything",
            targets: ["Genything"]
        ),
        .library(
            name: "GenythingTest",
            targets: ["GenythingTest"]
        ),
        .library(
            name: "Trickery",
            targets: ["Trickery"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Genything",
            dependencies: []
        ),
        .testTarget(
            name: "GenythingTests",
            dependencies: ["Genything", "GenythingTest"]
        ),
        .target(
            name: "GenythingTest",
            dependencies: ["Genything"]
        ),
        .testTarget(
            name: "GenythingTestTests",
            dependencies: ["Genything", "GenythingTest"]
        ),
        .target(
            name: "Trickery",
            dependencies: ["Genything"],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "TrickeryTests",
            dependencies: ["Genything", "Trickery", "GenythingTest"]
        ),
    ]
)
