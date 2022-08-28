//
//  DiskCacheContainer.swift
//
//
//  Created by Elon on 2022/08/28.
//

import Foundation

import RxRelay
import RxSwift

// MARK: - DiskCacheContainerLogic

public protocol DiskCacheContainerLogic {
  var container: UserDefaults { get }
  func setContainer(_ container: UserDefaults)
}

// MARK: - DiskCacheContainer

public final class DiskCacheContainer: DiskCacheContainerLogic {

  public static let shared = DiskCacheContainer()

  @DelayedMutable
  public private(set) var container: UserDefaults

  // MARK: Initializing

  convenience init(container: UserDefaults) {
    self.init()
    self.container = container
  }

  private init() {}

  public func setContainer(_ container: UserDefaults) {
    self.container = container
  }
}

// MARK: - DiskCacheContainer.Property

extension DiskCacheContainer {
  @propertyWrapper
  public class Property<Value> {
    let key: String
    let defaultValue: Value
    let diskCache: DiskCacheContainerLogic

    lazy var relay = BehaviorRelay(value: self.defaultValue)

    public var wrappedValue: Value {
      get {
        self.diskCache.container.object(forKey: self.key) as? Value ?? self.defaultValue
      }
      set {
        if let optional = newValue as? AnyOptional, optional.isNil {
          self.diskCache.container.removeObject(forKey: self.key)
        } else {
          self.diskCache.container.set(newValue, forKey: self.key)
        }
        self.relay.accept(newValue)
      }
    }

    open var projectedValue: Observable<Value> { self.relay.asObservable() }

    public init(
      key: String,
      defaultValue: Value,
      diskCache: DiskCacheContainerLogic = DiskCacheContainer.shared
    ) {
      self.key = key
      self.defaultValue = defaultValue
      self.diskCache = diskCache
    }
  }
}

// MARK: - DiskCacheContainer.CodableProperty

extension DiskCacheContainer {

  @propertyWrapper
  public final class CodableProperty<Value: Codable>: Property<Value> {

    override public var wrappedValue: Value {
      get {
        self.diskCache.container.codable(for: self.key) ?? self.defaultValue
      }
      set {
        if let optionalValue = newValue as? AnyOptional, optionalValue.isNil {
          self.diskCache.container.removeObject(forKey: self.key)
        } else {
          self.diskCache.container.setCodable(value: newValue, for: self.key)
        }
      }
    }

    override public var projectedValue: Observable<Value> { self.relay.asObservable() }
  }
}
