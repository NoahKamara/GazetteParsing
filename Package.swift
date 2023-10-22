// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GazetteParsing",
	platforms: [
		.macOS(.v14),
		.iOS(.v17),
		.watchOS(.v10),
		.visionOS(.v1)
	],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GazetteParsing",
            targets: ["GazetteParsing"]),
    ],
	dependencies: [
		.package(name: "GazetteCore", path: "../GazetteCore"),
		.package(url: "https://github.com/nmdias/FeedKit", from: "9.1.2"),
		.package(url: "https://github.com/will-lumley/FaviconFinder.git", from: "4.1.0"),
	],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GazetteParsing",
			dependencies: [
				"GazetteCore",
				"FeedKit",
				"FaviconFinder"
			]
		),
        .testTarget(
            name: "GazetteParsingTests",
            dependencies: ["GazetteParsing"]),
    ]
)
