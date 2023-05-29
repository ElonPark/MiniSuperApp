//
//  ParametersDefinable.swift
//
//
//  Created by Elon on 2022/12/29.
//

import Foundation

// MARK: - ParametersDefinable

public protocol ParametersDefinable: AnyOptionalCheckable {
  var additionalDefineParameters: [String: Any?] { get }
}

extension ParametersDefinable {
  public var additionalDefineParameters: [String: Any?] { [:] }
}

extension ParametersDefinable {
  public var parameters: [String: Any] {
    var defineParameters = additionalDefineParameters.compactMapValues { $0 }
    defineParameters.merge(generateParameters()) { define, _ in define }
    return defineParameters
  }

  private func generateParameters() -> [String: Any] {
    Mirror(reflecting: self)
      .children
      .compactMap { keyValuePair(from: $0) }
      .reduce(into: [String: Any]()) {
        $0[$1.key] = $1.Value
      }
  }

  private func keyValuePair(from child: Mirror.Child) -> (key: String, Value: Any)? {
    guard let pair = child.value as? AnyKeyValuePair,
          var key = pair.parameterizedKey.key ?? generateKey(from: child, pair: pair),
          isNil(pair.anyValue) == false
    else {
      return nil
    }

    if pair.parameterizedKey.useSnakeCase {
      key = key.toSnakeCase
    }

    return (key, pair.anyValue)
  }

  private func generateKey(from child: Mirror.Child, pair: AnyKeyValuePair) -> String? {
    guard pair.parameterizedKey.shouldRemoveUnderscorePrefix else { return child.label }
    return child.label.map {
      guard $0.hasPrefix("_") else { return $0 }
      return String($0.dropFirst(1))
    }
  }
}
