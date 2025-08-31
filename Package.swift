// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Sylvester",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Sylvester",
            targets: ["Sylvester"]
        ),
        .executable(
            name: "SylvesterGenerateBoilerplate",
            targets: ["SylvesterGenerateBoilerplate"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Mx-Iris/SourceKitten", branch: "main"),
        .package(url: "https://github.com/Mx-Iris/FrameworkToolbox", branch: "main"),
        .package(url: "https://github.com/groue/GRMustache.swift", branch: "master"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.0"),
        .package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.5.0"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", "509.1.0" ..< "602.0.0"),
        .package(url: "https://github.com/mesqueeb/CaseAnything", from: "0.1.8"),
    ],
    targets: [
        .target(
            name: "Sylvester",
            dependencies: [
                "SylvesterEnumerations",
                "SylvesterMacros",
                .product(name: "FoundationToolbox", package: "FrameworkToolbox"),
                .product(name: "SourceKittenFramework", package: "SourceKitten"),
                .product(name: "MetaCodable", package: "MetaCodable"),
                .product(name: "HelperCoders", package: "MetaCodable"),
            ]
        ),
        .target(
            name: "SylvesterEnumerations"
        ),
        .executableTarget(
            name: "SylvesterGenerateBoilerplate",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections"),
                .product(name: "CaseAnything", package: "CaseAnything"),
            ]
        ),
        .macro(
            name: "SylvesterMacros",
            dependencies: [
                "SylvesterEnumerations",
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "SylvesterTests",
            dependencies: ["Sylvester", .product(name: "Mustache", package: "GRMustache.swift")],
            exclude: ["Fixtures"]
        ),
    ],
    swiftLanguageModes: [.v5]
)
