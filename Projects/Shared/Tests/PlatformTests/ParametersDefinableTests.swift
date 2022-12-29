//
//  ParametersDefinableTests.swift
//
//
//  Created by Elon on 2022/12/29.
//

import XCTest

import AppTestSupport
@testable import Platform

// MARK: - ParametersDefinableTests

final class ParametersDefinableTests: XCTestCase {

  private struct Dummy: ParametersDefinable {

    @Parameterized
    var _underscoreValue: String = "_test"

    @Parameterized
    var camelCaseValue: String = "test"

    @Parameterized(key: "snake_case_value")
    var snakeCaseValue: String = "sneakCaseValueTest"

    @Parameterized(useSnakeCaseKey: true)
    var snakeCaseValue2 = "sneakCaseValueTest2"

    @Parameterized
    var nilValue: String?

    @Parameterized
    var nullValue = NSNull()

    let dummyKey = DummyKey()
  }

  private struct DummyKey: AnyKeyValuePair {
    var parameterizedKey: ParameterizedKey {
      ParameterizedKey(
        key: nil,
        useSnakeCase: true
      )
    }

    var anyValue: Any = "DummyKey" as Any
  }
}

extension ParametersDefinableTests {

  func test_underscoreValue() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["_underscoreValue"] as? String, "_test")
  }

  func test_cameCaseValue() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["camelCaseValue"] as? String, "test")
  }

  func test_snake_case_value() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["snake_case_value"] as? String, "sneakCaseValueTest")
  }

  func test_snake_case_value2() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["snake_case_value2"] as? String, "sneakCaseValueTest2")
  }

  func test_nilValue() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertNil(result["nilValue"])
  }

  func test_nullValue() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertNil(result["nullValue"])
  }

  func test_anyKeyValuePair_protocol() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["dummy_key"] as? String, "DummyKey")
  }
}
