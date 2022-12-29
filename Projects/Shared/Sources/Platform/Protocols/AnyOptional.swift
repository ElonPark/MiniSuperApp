//
//  AnyOptional.swift
//  Platform
//
//  Created by Elon on 2022/07/19.
//

import Foundation

// MARK: - AnyOptional

/// Allows to match for optionals with generics that are defined as non-optional.
public protocol AnyOptional {
  /// Returns `true` if `nil`, otherwise `false`.
  var isNil: Bool { get }
}

// MARK: - Optional + AnyOptional

extension Optional: AnyOptional {
  public var isNil: Bool { self == nil }
}

// MARK: - AnyOptionalCheckable

public protocol AnyOptionalCheckable {
  func isNil(_ value: Any) -> Bool
}

extension AnyOptionalCheckable {
  public func isNil(_ value: Any) -> Bool {
    let isOptionalNil = (value as? AnyOptional)?.isNil ?? false
    return isOptionalNil || value is NSNull
  }
}
