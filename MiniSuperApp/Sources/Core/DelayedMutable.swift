//
//  DelayedMutable.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/11.
//

import Foundation

@propertyWrapper
public struct DelayedMutable<Value> {

  private var value: Value?

  public var wrappedValue: Value {
    get {
      guard let value = self.value else {
        fatalError("property accessed before being initialized: \(Value.self)")
      }
      return value
    }
    set {
      self.value = newValue
    }
  }

  public init() {}
}
