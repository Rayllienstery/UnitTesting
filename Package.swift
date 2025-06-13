// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UnitTesting",
  platforms: [
    .iOS(.v17),
    .macOS(.v15)
  ],
  products: [
    .library(
      name: "UnitTesting",
      targets: ["UnitTesting"]
    )
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "UnitTesting"
    ),
    .testTarget(
      name: "UnitTestingTests",
      dependencies: ["UnitTesting"]
    )
  ]
)
