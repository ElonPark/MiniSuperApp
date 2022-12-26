import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "SplashSample",
  platform: .iOS,
  scripts: [
    Project.needleGenerateScriptForFeature(),
  ],
  additionalTargetDependency: [
    RemoteDependencies.needleFoundation.package,
    CoreDependencies.network.package,
    DataDependencies.bootstrapData.package,
    FeatureDependencies.splash.package,
  ],
  additionalPackages: [
    RemoteDependencies.needleFoundation.packageSource,
    CoreDependencies.network.packageSource,
    DataDependencies.bootstrapData.packageSource,
    FeatureDependencies.splash.packageSource,
  ]
)
