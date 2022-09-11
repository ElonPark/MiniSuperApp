// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "AppFoundation",
      targets: ["AppFoundation"]
    ),
    .library(
      name: "AppTestSupport",
      targets: ["AppTestSupport"]
    ),
    .library(
      name: "Platform",
      targets: ["Platform"]
    ),
    .library(
      name: "Network",
      targets: ["Network"]
    ),
    .library(
      name: "Entity",
      targets: ["Entity"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/uber/RIBs.git", branch: "main"),
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0"),
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0"))
  ],
  targets: [
    .target(
      name: "AppFoundation",
      dependencies: ["RIBs"]
    ),
    .target(
      name: "AppTestSupport",
      dependencies: ["RIBs"]
    ),
    .target(
      name: "Platform",
      dependencies: [
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "RxRelay", package: "RxSwift"),
        "Entity"
      ]
    ),
    .target(
      name: "Network",
      dependencies: [
        .product(name: "RxMoya", package: "Moya")
      ]
    ),
    .target(
      name: "Entity",
      dependencies: []
    ),
    .testTarget(
      name: "PlatformTests",
      dependencies: ["Platform"]
    ),
    .testTarget(
      name: "NetworkTests",
      dependencies: ["Network"]
    )
  ]
)
