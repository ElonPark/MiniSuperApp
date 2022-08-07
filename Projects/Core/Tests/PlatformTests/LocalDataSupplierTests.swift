//
//  LocalDataSupplierTests.swift
//
//
//  Created by Elon on 2022/07/19.
//

import Foundation
import XCTest

import Entity
@testable import Platform

// MARK: - LocalDataSupplierTests

final class LocalDataSupplierTests: XCTestCase {

  var userDefaults: UserDefaultsStub!
  var sut: LocalDataSupplier!

  override func setUpWithError() throws {
    try super.setUpWithError()
    self.userDefaults = UserDefaultsStub()
    self.sut = LocalDataSupplier(container: self.userDefaults)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
    self.userDefaults = nil
    self.sut = nil
  }
}

// MARK: Property

extension LocalDataSupplierTests {
  func test_isFirstLaunch을_호출하면_기본값으로_true를_반환해요() throws {
    // when
    let result = self.sut.isFirstLaunch

    // then
    XCTAssertTrue(result)
  }

  func test_isFirstLaunch값을_변경하면_userDefaults에_저장해요() throws {
    // given
    let inputValue = false

    // when
    self.sut.isFirstLaunch = inputValue
    let result = self.sut.isFirstLaunch

    // then
    XCTAssertEqual(result, inputValue)

    let savedValue = self.userDefaults.value(forKey: "isFirstLaunch") as? Bool
    XCTAssertEqual(savedValue, inputValue)
  }
}

// MARK: CodableProperty

extension LocalDataSupplierTests {

  func test_user을_호출하면_기본값으로_nil을_반환해요() {
    // when
    let result = self.sut.user

    // then
    XCTAssertNil(result)
  }

  func test_user값을_변경하면_userDefaults에_저장해요() {
    // given
    let inputValue = User(id: 999, name: "test", token: "uuid")

    // when
    self.sut.user = inputValue
    let result = self.sut.user

    // then
    XCTAssertEqual(result, inputValue)

    let savedValue: User? = self.userDefaults.codable(for: "user")
    XCTAssertEqual(savedValue, inputValue)
  }

  func test_user값을_nil로_변경하면_userDefaults에서_제거해요() {
    // given
    self.sut.user = User(id: 999, name: "test", token: "uuid")

    // when
    self.sut.user = nil
    let result = self.sut.user

    // then
    XCTAssertNil(result)

    let savedValue: User? = self.userDefaults.codable(for: "user")
    XCTAssertNil(savedValue)
  }
}

// MARK: Observable Property

extension LocalDataSupplierTests {

  func test_user값을_변경하면_Observable로_방출해요() async throws {
    // given
    let inputValues = [
      User(id: 1, name: "test", token: "uuid"),
      User(id: 2, name: "test", token: "uuid"),
      User(id: 3, name: "test", token: "uuid")
    ]

    // when
    var outputValues = [User]()
    _ = self.sut.userObservable
      .compactMap { $0 }
      .subscribe(onNext: {
        outputValues.append($0)
      })

    inputValues.forEach {
      self.sut.user = $0
    }

    // then
    XCTAssertEqual(outputValues, inputValues)
  }
}
