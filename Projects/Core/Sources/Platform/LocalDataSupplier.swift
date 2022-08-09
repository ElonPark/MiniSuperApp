//
//  LocalDataSupplier.swift
//  Platform
//
//  Created by Elon on 2022/07/19.
//

import Foundation

import RxRelay
import RxSwift

import Entity

// MARK: - LocalDataSupplierProtocol

public protocol LocalDataSupplierProtocol {
  var isFirstLaunch: Bool { get set }
  var user: User? { get set }
  var userObservable: Observable<User?> { get }
}

// MARK: - LocalDataSupplier

public final class LocalDataSupplier: LocalDataSupplierProtocol {

  // MARK: Properties

  @Property(key: "isFirstLaunch", defaultValue: true)
  public var isFirstLaunch: Bool

  @CodableProperty(key: "user", defaultValue: nil)
  public var user: User?
  public var userObservable: Observable<User?> { self.$user }

  // MARK: Private

  @DelayedMutable
  private static var container: UserDefaults

  // MARK: Initializing

  public init(container: UserDefaults) {
    Self.container = container
  }
}

// MARK: - LocalDataSupplier.Property

extension LocalDataSupplier {
  @propertyWrapper
  public class Property<Value> {
    let key: String
    let defaultValue: Value
    let relay: BehaviorRelay<Value>

    var container: UserDefaults?
    private var _container: UserDefaults {
      self.container ?? LocalDataSupplier.container
    }

    public var wrappedValue: Value {
      get {
        self._container.object(forKey: self.key) as? Value ?? self.defaultValue
      }
      set {
        if let optional = newValue as? AnyOptional, optional.isNil {
          self._container.removeObject(forKey: self.key)
        } else {
          self._container.set(newValue, forKey: self.key)
        }
        self.relay.accept(newValue)
      }
    }

    open var projectedValue: Observable<Value> { self.relay.asObservable() }

    public init(
      key: String,
      defaultValue: Value,
      container: UserDefaults? = nil
    ) {
      self.key = key
      self.defaultValue = defaultValue
      self.container = container
      self.relay = BehaviorRelay(value: self.defaultValue)
    }
  }
}

// MARK: - LocalDataSupplier.CodableProperty

extension LocalDataSupplier {

  @propertyWrapper
  public final class CodableProperty<Value: Codable>: Property<Value> {

    private var _container: UserDefaults {
      self.container ?? LocalDataSupplier.container
    }

    override public var wrappedValue: Value {
      get {
        self._container.codable(for: self.key) ?? self.defaultValue
      }
      set {
        if let optional = newValue as? AnyOptional, optional.isNil {
          self._container.removeObject(forKey: self.key)
        } else {
          self._container.setCodable(value: newValue, for: self.key)
        }
        self.relay.accept(newValue)
      }
    }

    override public var projectedValue: Observable<Value> { self.relay.asObservable() }
  }
}
