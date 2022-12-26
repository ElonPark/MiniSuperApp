//
//  FeatureDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/12/26.
//

import ProjectDescription

// MARK: - FeatureDependencies

public enum FeatureDependencies: String, CaseIterable, Packageable {
  case splash
  case loggedOut

  public var packageSource: Package { .package(path: path) }
  private var path: Path { .relativeToRoot("Projects/Feature/\(packageName)") }
}

// MARK: - FeatureDependencies.TestSupport

extension FeatureDependencies {
  public enum TestSupport: String, CaseIterable, Packageable {
    case splashTestSupport
    case loggedOutTestSupport

    public var packageSource: Package { .package(path: path) }
    private var path: Path {
      let path = String(packageName.dropLast("TestSupport".count))
      return .relativeToRoot("Projects/Feature/\(path)")
    }
  }
}
