//
//  LocalDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/08/05.
//

import ProjectDescription

public enum LocalDependencies {}

extension LocalDependencies {
  public enum Core: String, CaseIterable, Packageable {
    case appFoundation
    case platform
    case entity
    case network

    public var packageSource: Package { .local(path: "../Core/\(self.packageName)") }
  }
}

extension LocalDependencies {
  public enum Shared: String, CaseIterable, Packageable {
    case appResource
    case localization

    public var packageSource: Package { .local(path: "../Shared/\(self.packageName)") }
  }
}
