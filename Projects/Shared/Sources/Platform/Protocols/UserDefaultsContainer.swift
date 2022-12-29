//
//  UserDefaultsContainer.swift
//
//
//  Created by Elon on 2022/12/28.
//

import Foundation

// MARK: - UserDefaultsContainer

public protocol UserDefaultsContainer: AnyObject {
  var userDefaults: UserDefaults { get }
}

extension UserDefaultsContainer {
  public func register(userDefaultsContainer: UserDefaultsContainer) {
    Mirror(reflecting: self)
      .children
      .compactMap { $0.value as? UserDefaultsContainerRegistrable }
      .forEach { $0.register(container: self) }
  }
}

// MARK: - UserDefaultsContainerRegistrable

public protocol UserDefaultsContainerRegistrable {
  func register(container: UserDefaultsContainer)
}
