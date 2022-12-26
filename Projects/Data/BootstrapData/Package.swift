// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BootstrapData",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "BootstrapData",
      targets: ["BootstrapData"]
    ),
    .library(
      name: "BootstrapDomain",
      targets: ["BootstrapDomain"]
    ),
    .library(
      name: "BootstrapDomainTestSupport",
      targets: ["BootstrapDomainTestSupport"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0"),
    .package(path: "../../Core"),
    .package(path: "../../Shared"),
  ],
  targets: [
    .target(
      name: "BootstrapDomain",
      dependencies: [
        .product(name: "RxSwift", package: "RxSwift"),
      ]
    ),
    .target(
      name: "BootstrapDomainTestSupport",
      dependencies: [
        "BootstrapDomain",
      ]
    ),
    .target(
      name: "BootstrapData",
      dependencies: [
        "BootstrapDomain",
        .product(name: "NetworkInterface", package: "Core"),
      ]
    ),
    .testTarget(
      name: "BootstrapDataTests",
      dependencies: [
        "BootstrapData",
        .product(name: "NetworkTestSupport", package: "Core"),
      ]
    ),
  ]
)
