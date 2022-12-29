//
//  ParameterizedKey.swift
//
//
//  Created by Elon on 2022/12/30.
//

import Foundation

public struct ParameterizedKey {

  public var key: String?
  public var useSnakeCase: Bool
  var shouldRemoveUnderscorePrefix: Bool

  public init(key: String?, useSnakeCase: Bool) {
    self.key = key
    self.useSnakeCase = useSnakeCase
    self.shouldRemoveUnderscorePrefix = false
  }

  init(key: String?, useSnakeCase: Bool, shouldRemoveUnderscorePrefix: Bool) {
    self.key = key
    self.useSnakeCase = useSnakeCase
    self.shouldRemoveUnderscorePrefix = shouldRemoveUnderscorePrefix
  }
}
