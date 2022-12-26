import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - AppTarget

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
    Project.needleGenerateScript(),
  ],
  dependencies: [
    RemoteDependencies.allPackages,
    SharedDependencies.allPackages,
    CoreDependencies.allPackages,
    DataDependencies.allPackages,
    FeatureDependencies.allPackages,
  ].flatMap { $0 },
  settings: Project.defaultSettings()
)

// MARK: - TestTarget

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
    [
      .xctest,
      .target(name: "MiniSuperApp"),
    ],
    CoreDependencies.TestSupport.allPackages,
    DataDependencies.TestSupport.allPackages,
    FeatureDependencies.TestSupport.allPackages,
  ].flatMap { $0 },
  settings: Project.defaultSettings()
)

// MARK: - Project

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
  packages: [
    RemoteDependencies.allPackageSource,
    SharedDependencies.allPackageSource,
    CoreDependencies.allPackageSource,
    DataDependencies.allPackageSource,
    FeatureDependencies.allPackageSource,
  ].flatMap { $0 },
  settings: Project.defaultSettings(),
  targets: [
    appTarget,
    testTarget,
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
    ),
  ]
)
