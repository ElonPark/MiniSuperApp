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

    public var packageSourceForSample: Package { .local(path: "../\(self.packageName)") }
    public var packageSource: Package { .local(path: "../Feature/\(self.packageName)") }
  }
}

extension LocalDependencies {
  public enum Core: String, CaseIterable, Packageable {
    case appCore
    case appFoundation
    case platform
    case network
    case entity

    public var packageSource: Package { .local(path: "../Core/\(self.packageName)") }
  }
}

extension LocalDependencies {
  public enum Shared: String, CaseIterable, Packageable {
    case appResource
    case designSystem
    case localization

    public var packageSource: Package { .local(path: "../Shared/\(self.packageName)") }
  }
}
