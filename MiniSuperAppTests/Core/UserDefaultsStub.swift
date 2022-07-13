//
//  UserDefaultsStub.swift
//  MiniSuperAppTests
//
//  Created by Elon on 2022/07/11.
//

import Foundation

final class UserDefaultsStub: UserDefaults {

  override init?(suiteName: String?) {
    super.init(suiteName: "com.elonpark.MiniSuperApp.UserDefaultsStub")
  }

  deinit {
    self.dictionaryRepresentation().keys.forEach { key in
      self.removeObject(forKey: key)
    }
  }
}
