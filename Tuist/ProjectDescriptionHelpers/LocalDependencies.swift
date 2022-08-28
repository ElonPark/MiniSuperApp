//
//  LocalDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/08/05.
//

import ProjectDescription

public enum LocalDependencies {}

extension LocalDependencies {
  public enum Feature: String, CaseIterable, Packageable {
    case splash

    public var packageSource: Package { .package(path: self.path) }
    private var path: Path { .relativeToRoot("Projects/Feature/\(self.packageName)") }
  }
}

extension LocalDependencies {
  public enum TestSupport: String, CaseIterable, Packageable {
    case appTestSupport
    case splashTestSupport

    public var packageSource: Package {
      switch self {
      case .appTestSupport:
        return .package(path: .relativeToRoot("Projects/Core"))
      case .splashTestSupport:
        let path = self.packageName.replacingOccurrences(of: "TestSupport", with: "")
        return .package(path: .relativeToRoot("Projects/Feature/\(path)"))
      }
    }
  }
}

extension LocalDependencies {
  public enum Core: String, CaseIterable, Packageable {
    case appFoundation
    case platform
    case network
    case entity

    public var packageSource: Package {
      .package(path: .relativeToRoot("Projects/Core"))
    }

    public static var allPackageSource: [Package] {
      [.package(path: .relativeToRoot("Projects/Core"))]
    }
  }
}

extension LocalDependencies {
  public enum Shared: String, CaseIterable, Packageable {
    case appResource
    case designSystem
    case localization

    public var packageSource: Package {
      .package(path: .relativeToRoot("Projects/Shared"))
    }

    public static var allPackageSource: [Package] {
      [.package(path: .relativeToRoot("Projects/Shared"))]
    }
  }
}
