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

public final class UserStreamImpl: MutableUserStream, UserDefaultsContainer {

  // MARK: UserStream

  @CodableDefaults(key: "currentUser", default: nil)
  public private(set) var user: User?
  public var userObservable: Observable<User?> { $user }

  // MARK: Private

  public var userDefaults: UserDefaults

  // MARK: Initializing

  public init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
    _user.register(self)
  }

  public func configure(user: User?) {
    self.user = user
  }
}
