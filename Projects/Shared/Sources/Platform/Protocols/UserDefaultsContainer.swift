//
//  UserDefaultsContainer.swift
//
//
//  Created by Elon on 2022/12/28.
//

import Foundation

public protocol UserDefaultsContainer: AnyObject {
  var userDefaults: UserDefaults { get }
}
