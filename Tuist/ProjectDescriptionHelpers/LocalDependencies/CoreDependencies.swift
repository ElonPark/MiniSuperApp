//
//  CoreDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/12/26.
//

import ProjectDescription

// MARK: - CoreDependencies

public enum CoreDependencies: String, CaseIterable, Packageable {
  case network
  case userStream

  public var packageSource: Package {
    .package(path: .relativeToRoot("Projects/Core"))
  }

  public static var allPackageSource: [Package] {
    [.package(path: .relativeToRoot("Projects/Core"))]
  }
}

// MARK: - CoreDependencies.TestSupport

extension CoreDependencies {
  public enum TestSupport: String, CaseIterable, Packageable {
    case appTestSupport

    public var packageSource: Package { .package(path: path) }
    private var path: Path {
      switch self {
      case .appTestSupport:
        return .relativeToRoot("Projects/Core")
      }
    }
  }
}
