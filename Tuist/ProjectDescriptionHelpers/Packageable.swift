//
//  Packageable.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/08/05.
//

import ProjectDescription

// MARK: - Packageable

public protocol Packageable {
  var packageSource: Package { get }
  static var allPackages: [TargetDependency] { get }
  static var allPackageSource: [Package] { get }
}

extension Packageable where Self: CaseIterable, Self: RawRepresentable, Self.RawValue == String {
  public static var allPackages: [TargetDependency] { allCases.map(\.package) }
  public static var allPackageSource: [Package] { allCases.map(\.packageSource) }
}

extension RawRepresentable where Self.RawValue == String {
  public var packageName: String { rawValue.firstUppercased }
  public var package: TargetDependency { .package(product: packageName) }
}
