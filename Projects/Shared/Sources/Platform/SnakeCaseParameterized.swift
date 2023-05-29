//
//  SnakeCaseParameterized.swift
//
//
//  Created by Elon on 2023/05/30.
//

import Foundation

@propertyWrapper
public struct SnakeCaseParameterized<Value>: AnyKeyValuePair {

  public var wrappedValue: Value {
    get { value }
    set { value = newValue }
  }

  public var parameterizedKey: ParameterizedKey {
    ParameterizedKey(
      key: nil,
      useSnakeCase: true,
      shouldRemoveUnderscorePrefix: true // propertyWrapper 사용시 label에 `_`가 붙기 때문에 제거
    )
  }

  public var anyValue: Any { wrappedValue as Any }

  private var value: Value

  // MARK: Initializing

  public init(wrappedValue value: Value) {
    self.value = value
  }
}
