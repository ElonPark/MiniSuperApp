//
//  UserDefaultsContainerTests.swift
//
//
//  Created by Elon on 2022/12/29.
//

import XCTest

import AppTestSupport
@testable import Platform

// MARK: - UserDefaultsContainerTests

final class UserDefaultsContainerTests: XCTestCase, UserDefaultsContainer {

  var userDefaultsStub: UserDefaultsStub!
  var userDefaults: UserDefaults { userDefaultsStub }

  @Defaults(key: "userName", default: "foo")
  var userName: String

  override func setUpWithError() throws {
    try super.setUpWithError()
    userDefaultsStub = UserDefaultsStub()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
    userDefaultsStub = nil
  }
}

// MARK: register

extension UserDefaultsContainerTests {

  func test_register_userDefaultsContainer() {
    // given
    let inputValue = "test"

    // when
    register(userDefaultsContainer: self)

    userName = inputValue

    // then
    XCTAssertEqual(userName, inputValue)

    let savedValue: String? = userDefaults.string(forKey: "userName")
    XCTAssertEqual(savedValue, inputValue)
  }
}
