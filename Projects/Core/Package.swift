// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "NetworkInterface",
      targets: ["NetworkInterface"]
    ),
    .library(
      name: "Network",
      targets: ["Network"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0"),
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0"))
  ],
  targets: [
    .target(
      name: "NetworkInterface",
      dependencies: [
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "RxMoya", package: "Moya")
      ]
    ),
    .target(
      name: "Network",
      dependencies: [
        "NetworkInterface"
      ]
    ),
    .testTarget(
      name: "NetworkTests",
      dependencies: ["Network"]
    )
  ]
)
