//
//  LocalDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/08/05.
//

import ProjectDescription

public enum LocalDependencies {
  public enum Shared: String, CaseIterable, Packageable {
    case appFoundation
    case appResource
    case entity
    case localization
    case network
    case platform

    public var packageSource: Package { .local(path: "../\(self.packageName)") }
  }
}
