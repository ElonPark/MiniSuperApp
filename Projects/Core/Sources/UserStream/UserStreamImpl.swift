//
//  UserStreamImpl.swift
//
//
//  Created by Elon on 2022/09/12.
//

import Foundation

import RxSwift

import Platform
import UserStreamInterface

public final class UserStreamImpl: MutableUserStream {

  // MARK: UserStream

  public var user: User? { self.userProperty }
  public var userObservable: Observable<User?> { self.$userProperty }

  // MARK: Private

  @DiskCache.CodableProperty(
    key: "currentUser",
    defaultValue: nil,
    diskCache: UserStreamImpl.diskCache.container
  )
  private var userProperty: User?

  @DelayedMutable
  private static var diskCache: DiskCache

  // MARK: Initializing

  public init(diskCache: DiskCache) {
    Self.diskCache = diskCache
  }

  // MARK: MutableUserStream

  public func setUser(_ user: User?) {
    self.userProperty = user
  }
}
