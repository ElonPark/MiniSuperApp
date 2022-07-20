// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppFoundation",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "AppFoundation",
      targets: ["AppFoundation"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/uber/RIBs.git", branch: "main")
  ],
  targets: [
    .target(
      name: "AppFoundation",
      dependencies: [
        "RIBs"
      ]
    ),
    .testTarget(
      name: "AppFoundationTests",
      dependencies: ["AppFoundation"]
    )
  ]
)
