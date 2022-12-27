//
//  UserDefaultWrapperTests.swift
//
//
//  Created by Elon on 2022/12/28.
//

import XCTest

import AppTestSupport
@testable import Platform

// MARK: - UserDefaultWrapperTests

final class UserDefaultWrapperTests: XCTestCase, UserDefaultsContainer {

  private struct CodableDummy: Codable, Equatable {
    let string: String
  }

  var userDefaultsStub: UserDefaultsStub!
  var userDefaults: UserDefaults { userDefaultsStub }

  override func setUpWithError() throws {
    try super.setUpWithError()
    userDefaultsStub = UserDefaultsStub()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
    userDefaultsStub = nil
  }
}

// MARK: Defaults

extension UserDefaultWrapperTests {

  func test_defaults_저장되어_있는_값이_없을때_호출하면_기본값으로_nil을_반환해요() {
    // when
    @Defaults(key: "userName", default: nil, container: self)
    var value: String?

    // then
    XCTAssertNil(value)

    let savedValue: String? = userDefaults.string(forKey: "userName")
    XCTAssertNil(savedValue)
  }

  func test_defaults_값을_전달하면_userDefaults에_저장해요() {
    // given
    let inputValue = "test"

    // when
    @Defaults(key: "userName", default: nil, container: self)
    var value: String?
    let result = value

    value = inputValue

    // then
    XCTAssertNil(result)
    XCTAssertEqual(value, inputValue)
  }

  func test_defaults_값을_변경하면_userDefaults에_저장해요() {
    // given
    let inputValue = "test"

    // when
    @Defaults(key: "userName", default: "foo", container: self)
    var value: String
    let result = value

    value = inputValue

    // then
    XCTAssertEqual(result, "foo")
    XCTAssertEqual(value, inputValue)

    let savedValue: String? = userDefaults.string(forKey: "userName")
    XCTAssertEqual(savedValue, inputValue)
  }

  func test_defaults_값을_nil로_변경하면_userDefaults에서_제거해요() {
    // given
    let inputValue1 = "test"
    let inputValue2: String? = nil

    // when
    @Defaults(key: "userName", default: nil, container: self)
    var value: String?

    value = inputValue1
    let result = value

    value = inputValue2

    // then
    XCTAssertEqual(result, inputValue1)
    XCTAssertNil(value)

    let savedValue: String? = userDefaults.string(forKey: "userName")
    XCTAssertNil(savedValue)
  }
}

// MARK: Observable Defaults

extension UserDefaultWrapperTests {

  func test_defaults_값을_변경하면_Observable로_방출해요() async throws {
    // given
    let inputValues = [
      "test1",
      "test2",
      "test3",
    ]

    // when
    @Defaults(key: "userName", default: nil, container: self)
    var value: String?

    var outputValues = [String]()
    _ = $value.compactMap { $0 }
      .subscribe(onNext: {
        outputValues.append($0)
      })

    inputValues.forEach { value = $0 }

    // then
    XCTAssertEqual(outputValues, inputValues)
  }
}

// MARK: CodableDefaults

extension UserDefaultWrapperTests {

  func test_codableDefaults_저장되어_있는_값이_없을때_호출하면_기본값으로_nil을_반환해요() {
    // when
    @CodableDefaults(key: "dummy", default: nil, container: self)
    var value: CodableDummy?
    let result = value

    // then
    XCTAssertNil(result)

    let savedValue: CodableDummy? = userDefaults.codable(forKey: "dummy")
    XCTAssertNil(savedValue)
  }

  func test_codableDefaults_값을_전달하면_userDefaults에_저장해요() {
    // given
    let inputValue = ["test": CodableDummy(string: "값")]

    // when
    @CodableDefaults(key: "dummy", default: [:], container: self)
    var value: [String: CodableDummy]
    let result = value

    value = inputValue

    // then
    XCTAssertTrue(result.isEmpty)

    XCTAssertEqual(value, inputValue)
    XCTAssertEqual(value["test"]?.string, "값")
  }

  func test_codableDefaults_dummy값을_변경하면_userDefaults에_저장해요() {
    // given
    let inputValue = CodableDummy(string: "test")

    // when
    @CodableDefaults(key: "dummy", default: nil, container: self)
    var value: CodableDummy?
    let result = value

    value = inputValue

    // then
    XCTAssertNil(result)
    XCTAssertEqual(value, inputValue)

    let savedValue: CodableDummy? = userDefaults.codable(forKey: "dummy")
    XCTAssertEqual(savedValue, inputValue)
  }

  func test_codableDefaults_dummy값을_nil로_변경하면_userDefaults에서_제거해요() {
    // given
    let inputValue1 = CodableDummy(string: "test")
    let inputValue2: CodableDummy? = nil

    // when
    @CodableDefaults(key: "dummy", default: nil, container: self)
    var value: CodableDummy?
    value = inputValue1
    let result = value

    value = inputValue2

    // then
    XCTAssertEqual(result, inputValue1)
    XCTAssertNil(value)

    let savedValue: CodableDummy? = userDefaults.codable(forKey: "dummy")
    XCTAssertNil(savedValue)
  }
}
