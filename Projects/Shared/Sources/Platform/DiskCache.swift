//
//  DiskCache.swift
//
//
//  Created by Elon on 2022/08/28.
//

import Foundation

import RxRelay
import RxSwift

// MARK: - DiskCacheContainer

public protocol DiskCacheContainer {
  var container: UserDefaults { get }
}

// MARK: - DiskCache

public final class DiskCache: DiskCacheContainer {

  public let container: UserDefaults

  // MARK: Initializing

  public init(container: UserDefaults) {
    self.container = container
  }
}

// MARK: - DiskCacheContainer.Property

extension DiskCache {
  @propertyWrapper
  public class Property<Value> {
    let key: String
    let defaultValue: Value
    let diskCache: () -> UserDefaults

    lazy var relay = BehaviorRelay(value: self.defaultValue)

    public var wrappedValue: Value {
      get {
        self.diskCache().object(forKey: self.key) as? Value ?? self.defaultValue
      }
      set {
        if let optional = newValue as? AnyOptional, optional.isNil {
          self.diskCache().removeObject(forKey: self.key)
        } else {
          self.diskCache().set(newValue, forKey: self.key)
        }
        self.relay.accept(newValue)
      }
    }

    open var projectedValue: Observable<Value> { self.relay.asObservable() }

    public init(
      key: String,
      defaultValue: Value,
      diskCache: @autoclosure @escaping () -> UserDefaults
    ) {
      self.key = key
      self.defaultValue = defaultValue
      self.diskCache = diskCache
    }
  }
}

// MARK: - DiskCacheContainer.CodableProperty

extension DiskCache {

  @propertyWrapper
  public final class CodableProperty<Value: Codable>: Property<Value> {

    override public var wrappedValue: Value {
      get {
        self.diskCache().codable(for: self.key) ?? self.defaultValue
      }
      set {
        if let optionalValue = newValue as? AnyOptional, optionalValue.isNil {
          self.diskCache().removeObject(forKey: self.key)
        } else {
          self.diskCache().setCodable(value: newValue, for: self.key)
        }
      }
    }

    override public var projectedValue: Observable<Value> { self.relay.asObservable() }
  }
}
