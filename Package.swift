// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sylvester",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Sylvester",
            targets: ["Sylvester"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Mx-Iris/SourceKitten", branch: "main"),
        .package(url: "https://github.com/groue/GRMustache.swift", branch: "master"),
    ],
    targets: [
        .target(
            name: "Sylvester",
            dependencies: [
                .product(name: "SourceKittenFramework", package: "SourceKitten"),
            ]
        ),
        
        .testTarget(
            name: "SylvesterTests",
            dependencies: ["Sylvester", .product(name: "Mustache", package: "GRMustache.swift")],
            exclude: ["Fixtures"]
        ),
    ]
    
)
