import ProjectDescription

// Project helpers are functions that simplify the way you define your project.
// Share code to create targets, settings, dependencies,
// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
// See https://docs.tuist.io/guides/helpers/

extension Project {
  public static func defaultSettings() -> Settings {
    .settings(
      base: ["GCC_PREPROCESSOR_DEFINITIONS": "FLEXLAYOUT_SWIFT_PACKAGE=1"],
      configurations: [
        .debug(
          name: .debug,
          settings: ["GCC_PREPROCESSOR_DEFINITIONS": .array(["DEBUG=1", "$(inherited)"])]
        ),
        .release(name: .release),
      ],
      defaultSettings: .recommended
    )
  }

  public static func needleGenerateScript() -> TargetScript {
    return .pre(
      script: """
      FILE_PATH="$SRCROOT/Sources/AppStart"
      export PATH="$PATH:/opt/homebrew/bin"
      export SOURCEKIT_LOGGING=0 && needle generate "${FILE_PATH}/NeedleGenerated.swift" \
      "$SRCROOT/../" \
      --exclude-suffixes Tests Mocks \
      --exclude-paths /Sample /Tests /Resources
      swiftformat ${FILE_PATH}/NeedleGenerated.swift
      """,
      name: "Needle"
    )
  }

  public static func needleGenerateScriptForFeature() -> TargetScript {
    return .pre(
      script: """
      FILE_PATH="$SRCROOT/Sources/AppStart"
      export PATH="$PATH:/opt/homebrew/bin"
      export SOURCEKIT_LOGGING=0 && needle generate "${FILE_PATH}/NeedleGenerated.swift" \
      "$SRCROOT/../" \
      --exclude-suffixes Tests Mocks \
      --exclude-paths /Tests /Resources
      swiftformat ${FILE_PATH}/NeedleGenerated.swift
      """,
      name: "Needle"
    )
  }

  /// Helper function to create the Project for this ExampleApp
  public static func app(
    name: String,
    platform: Platform,
    scripts: [TargetScript] = [],
    additionalTargetDependency: [TargetDependency],
    additionalPackages: [Package]
  ) -> Project {
    let targets = makeAppTargets(
      name: name,
      platform: platform,
      scripts: scripts,
      dependencies: additionalTargetDependency
    )

    return Project(
      name: name,
      organizationName: "com.elonpark",
      packages: additionalPackages,
      targets: targets,
      schemes: [
        Scheme(
          name: name,
          shared: true,
          buildAction: .buildAction(
            targets: [.init(stringLiteral: name)]
          ),
          testAction: .targets(["\(name)Tests"]),
          runAction: .runAction(configuration: .debug)
        ),
      ]
    )
  }

  // MARK: - Private

  /// Helper function to create a framework target and an associated unit test target
  private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
    let sources = Target(
      name: name,
      platform: platform,
      product: .framework,
      bundleId: "com.elonpark.\(name)",
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: [],
      dependencies: []
    )
    let tests = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "com.elonpark.\(name)Tests",
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [.target(name: name)]
    )
    return [sources, tests]
  }

  /// Helper function to create the application target and the unit test target.
  private static func makeAppTargets(
    name: String,
    platform: Platform,
    deploymentTarget: DeploymentTarget = .iOS(targetVersion: "14.0", devices: .iphone),
    scripts: [TargetScript] = [],
    dependencies: [TargetDependency]
  ) -> [Target] {
    let platform: Platform = platform
    let infoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UIMainStoryboardFile": "",
      "UILaunchStoryboardName": "LaunchScreen",
    ]

    let mainTarget = Target(
      name: name,
      platform: platform,
      product: .app,
      bundleId: "com.elonpark.\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: scripts,
      dependencies: dependencies,
      settings: Self.defaultSettings()
    )

    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "com.elonpark.\(name)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: "\(name)"),
      ],
      settings: Self.defaultSettings()
    )
    return [mainTarget, testTarget]
  }
}
