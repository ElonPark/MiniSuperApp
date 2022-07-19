import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
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
  settings: .settings(
    base: [:],
    configurations: [
      .debug(name: .debug),
      .release(name: .release)
    ],
    defaultSettings: .recommended
  ),
  targets: [
    Target(
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
      scripts: [],
      dependencies: [
        .external(name: "RIBs"),
        .external(name: "NeedleFoundation"),
        .external(name: "FlexLayout"),
        .external(name: "PinLayout"),
        .external(name: "Then"),
        .external(name: "Entity")
      ],
      settings: .settings(
        base: [:],
        configurations: [
          .debug(name: .debug),
          .release(name: .release)
        ],
        defaultSettings: .recommended
      )
    )
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
