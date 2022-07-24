import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let defaultSettings: Settings = .settings(
  base: [:],
  configurations: [
    .debug(name: .debug),
    .release(name: .release)
  ],
  defaultSettings: .recommended
)

let appTarget = Target(
  name: "MiniSuperApp",
  platform: .iOS,
  product: .app,
  productName: "MiniSuperApp",
  bundleId: "com.elonpark.MiniSuperApp",
  deploymentTarget: .iOS(
    targetVersion: "14.0",
    devices: .iphone
  ),
  infoPlist: .file(path: "SupportingFiles/MiniSuperApp-Info.plist"),
  sources: "Sources/**",
  resources: "Resources/**",
  scripts: [
    .pre(
      script: """
      FILE_PATH="$SRCROOT/Sources/AppStart"
      export PATH="$PATH:/opt/homebrew/bin"
      export SOURCEKIT_LOGGING=0 && needle generate "${FILE_PATH}/NeedleGenerated.swift" "$SRCROOT/../"
      swiftformat ${FILE_PATH}/NeedleGenerated.swift
      """,
      name: "Needle"
    )
  ],
  dependencies: [
    .external(name: "RIBs"),
    .external(name: "NeedleFoundation"),
    .external(name: "FlexLayout"),
    .external(name: "PinLayout"),
    .external(name: "Then"),
    .external(name: "Entity"),
    .external(name: "Platform"),
    .external(name: "AppFoundation"),
    .external(name: "AppResource"),
    .external(name: "Localization"),
    .external(name: "Network")
  ],
  settings: defaultSettings
)

let testTarget = Target(
  name: "MiniSuperAppTests",
  platform: .iOS,
  product: .unitTests,
  productName: "MiniSuperAppTests",
  bundleId: "com.elonpark.MiniSuperAppTests",
  deploymentTarget: .iOS(
    targetVersion: "14.0",
    devices: .iphone
  ),
  infoPlist: .default,
  sources: "Tests/**",
  dependencies: [
    .xctest,
    .target(name: "MiniSuperApp")
  ],
  settings: defaultSettings
)

let project = Project(
  name: "MiniSuperApp",
  organizationName: "elonpark",
  options: .options(
    automaticSchemesOptions: .disabled,
    disableBundleAccessors: true,
    disableSynthesizedResourceAccessors: true,
    textSettings: .textSettings(
      usesTabs: false,
      indentWidth: 2,
      tabWidth: 2,
      wrapsLines: true
    )
  ),
  settings: defaultSettings,
  targets: [
    appTarget,
    testTarget
  ],
  schemes: [
    Scheme(
      name: "MiniSuperApp",
      shared: true,
      buildAction: .buildAction(
        targets: ["MiniSuperApp"]
      ),
      testAction: .targets(["MiniSuperAppTests"]),
      runAction: .runAction(configuration: .release)
    ),
    Scheme(
      name: "DevMiniSuperApp",
      shared: true,
      buildAction: .buildAction(
        targets: ["MiniSuperApp"]
      ),
      testAction: .targets(
        ["MiniSuperAppTests"],
        options: .options(coverage: true)
      ),
      runAction: .runAction(configuration: .debug)
    )
  ]
)
