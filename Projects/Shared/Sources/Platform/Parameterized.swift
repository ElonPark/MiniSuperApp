//
//  Parameterized.swift
//
//
//  Created by Elon on 2022/12/29.
//

import Foundation
@propertyWrapper
public struct Parameterized<Value>: AnyKeyValuePair {

  public var wrappedValue: Value {
    get {
      guard let value else { fatalError("should be initialized before using!") }
      return value
    }
    set {
      value = newValue
    }
  }

  public var parameterizedKey: ParameterizedKey {
    ParameterizedKey(
      key: customKey,
      useSnakeCase: false,
      shouldRemoveUnderscorePrefix: true // propertyWrapper 사용시 label에 `_`가 붙기 때문에 제거
    )
  }

  public var anyValue: Any { wrappedValue as Any }

  private var value: Value?
  private var customKey: String? = nil

  // MARK: Initializing

  public init(key: String) {
    self.customKey = key
  }

  public init(wrappedValue value: Value) {
    self.value = value
  }

  public init(wrappedValue value: Value, key: String) {
    self.value = value
    self.customKey = key
  }
}
