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

    public var packageSourceForSample: Package {
      .package(path: .relativeToRoot("Projects/Core"))
    }
    public var packageSource: Package {
      .package(path: .relativeToRoot("Projects/Feature/\(self.packageName)"))
    }
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
