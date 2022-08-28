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
  var user: User? { get set }
}

// MARK: - LocalDataSupplier

public final class LocalDataSupplier: LocalDataSupplierProtocol {

  public typealias Property = DiskCacheContainer.Property
  public typealias CodableProperty = DiskCacheContainer.CodableProperty

  // MARK: Properties

  @CodableProperty(key: "user", defaultValue: nil)
  public var user: User?

  // MARK: Private

  private let container: DiskCacheContainerLogic

  // MARK: Initializing

  public init(
    userDefaults: UserDefaults,
    container: DiskCacheContainerLogic
  ) {
    self.container = container
    self.container.setContainer(userDefaults)
  }
}
