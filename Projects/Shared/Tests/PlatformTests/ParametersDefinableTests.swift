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

    @SnakeCaseParameterized
    var snakeCaseValue2 = "sneakCaseValueTest2"

    @Parameterized
    var nilValue: String?

    @SnakeCaseParameterized
    var nilValue2: String? = nil

    @Parameterized
    var nullValue = NSNull()

    @Parameterized
    var constructorInitTestValue1: String

    @SnakeCaseParameterized
    var constructorInitTestValue2: String

    @Parameterized(key: "constructor_init_test_value3")
    var constructorInitTestValue3: String

    let dummyKey = DummyKey()

    @SnakeCaseParameterized
    var overrideKeyTestValue: String? = "should_override"

    @SnakeCaseParameterized
    var pageID: Int = 999

    @SnakeCaseParameterized
    var pageURLString: String = "www.daangn.com"

    var additionalDefineParameters: [String: Any?] = [
      "additionalDefineParameter": "defined",
      "override_key_test_value": "did_override",
    ]

    init(
      constructorInitTestValue1: String = "constructorInit1",
      constructorInitTestValue2: String = "constructorInit2",
      constructorInitTestValue3: String = "constructorInit3"
    ) {
      self.constructorInitTestValue1 = constructorInitTestValue1
      self.constructorInitTestValue2 = constructorInitTestValue2
      self.constructorInitTestValue3 = constructorInitTestValue3
    }
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
    XCTAssertNil(result["nilValue2"])
  }

  func test_nullValue() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertNil(result["nullValue"])
  }

  func test_constructor_init() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["constructorInitTestValue1"] as? String, "constructorInit1")
    XCTAssertEqual(result["constructor_init_test_value2"] as? String, "constructorInit2")
    XCTAssertEqual(result["constructor_init_test_value3"] as? String, "constructorInit3")
  }

  func test_anyKeyValuePair_protocol() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["dummy_key"] as? String, "DummyKey")
  }

  func test_additionalDefineParameters_defined_key_value() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["additionalDefineParameter"] as? String, "defined")
  }

  func test_additionalDefineParameters_override_key_value() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters

    // then
    XCTAssertEqual(result["override_key_test_value"] as? String, "did_override")
  }

  func test_abbreviation_key_name() {
    // given
    let inputValue = Dummy()

    // when
    let result = inputValue.parameters
    // then
    XCTAssertEqual(result["page_id"] as? Int, 999)
    XCTAssertEqual(result["page_url_string"] as? String, "www.daangn.com")
  }
}
