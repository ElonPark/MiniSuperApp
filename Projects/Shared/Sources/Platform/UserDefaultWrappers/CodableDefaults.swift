//
//  CodableDefaults.swift
//
//
//  Created by Elon on 2022/12/28.
//

import Foundation

import RxRelay
import RxSwift

@propertyWrapper
public class CodableDefaults<Value: Codable>: Defaults<Value> {

  // MARK: - Public

  override public var wrappedValue: Value {
    get {
      userDefaults?.codable(forKey: key) ?? defaultValue
    }
    set {
      if let optional = newValue as? AnyOptional, optional.isNil {
        userDefaults?.removeObject(forKey: key)
      } else {
        userDefaults?.setCodable(value: newValue, forKey: key)
      }
      relay.accept(newValue)
    }
  }

  override public var projectedValue: Observable<Value> { relay.asObservable() }
}
