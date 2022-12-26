import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "LoggedOutSample",
  platform: .iOS,
  scripts: [
    Project.needleGenerateScriptForFeature(),
  ],
  additionalTargetDependency: [
    LocalDependencies.Feature.loggedOut.package,
    LocalDependencies.Core.network.package,
    RemoteDependencies.needleFoundation.package,
  ],
  additionalPackages: [
    LocalDependencies.Feature.loggedOut.packageSource,
    LocalDependencies.Core.network.packageSource,
    RemoteDependencies.needleFoundation.packageSource,
  ]
)
