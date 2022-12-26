//
//  DelayedMutable.swift
//  Platform
//
//  Created by Elon on 2022/07/19.
//

import Foundation

@propertyWrapper
public struct DelayedMutable<Value> {

  private var value: Value?

  public var wrappedValue: Value {
    get {
      guard let value else {
        fatalError("property accessed before being initialized: \(Value.self)")
      }
      return value
    }
    set {
      value = newValue
    }
  }

  public init() {}
}
