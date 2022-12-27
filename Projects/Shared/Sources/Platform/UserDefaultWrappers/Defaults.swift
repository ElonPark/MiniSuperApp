//
//  DefaultProperty.swift
//
//
//  Created by Elon on 2022/12/27.
//

import Foundation

import RxRelay
import RxSwift

@propertyWrapper
public class Defaults<Value> {

  // MARK: - Public

  public var wrappedValue: Value {
    get {
      userDefaults?.object(forKey: key) as? Value ?? defaultValue
    }
    set {
      if let optional = newValue as? AnyOptional, optional.isNil {
        userDefaults?.removeObject(forKey: key)
      } else {
        userDefaults?.set(newValue, forKey: key)
      }
      relay.accept(newValue)
    }
  }

  public var projectedValue: Observable<Value> { relay.asObservable() }

  // MARK: - Properties

  let key: String
  let defaultValue: Value

  private weak var container: UserDefaultsContainer?
  var userDefaults: UserDefaults? { container?.userDefaults }

  lazy var relay = BehaviorRelay(value: self.defaultValue)

  // MARK: - Initializing

  public init(
    key: String,
    default defaultValue: Value,
    container: UserDefaultsContainer? = nil
  ) {
    self.key = key
    self.defaultValue = defaultValue
    self.container = container
  }

  public func register(_ container: UserDefaultsContainer) {
    self.container = container
  }
}
