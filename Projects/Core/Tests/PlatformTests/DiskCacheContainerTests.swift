//
//  File.swift
//
//
//  Created by Elon on 2022/08/28.
//

import Foundation
import XCTest

import Entity
@testable import Platform

// MARK: - DiskCacheContainerTests

final class DiskCacheContainerTests: XCTestCase {

  typealias Property = DiskCacheContainer.Property
  typealias CodableProperty = DiskCacheContainer.CodableProperty

  private struct CodableDummy: Codable, Equatable {
    let string: String
  }

  var userDefaults: UserDefaultsStub!
  var diskCache: DiskCacheContainer!

  override func setUpWithError() throws {
    try super.setUpWithError()
    self.userDefaults = UserDefaultsStub()
    self.diskCache = DiskCacheContainer(container: self.userDefaults)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
    self.userDefaults = nil
    self.diskCache = nil
  }
}

// MARK: Property

extension DiskCacheContainerTests {

  func test_property_저장되어_있는_값이_없을때_호출하면_기본값으로_nil을_반환해요() {
    // when
    @Property(key: "userName", defaultValue: nil, diskCache: self.diskCache)
    var value: String?

    // then
    XCTAssertNil(value)

    let savedValue: String? = self.userDefaults.string(forKey: "userName")
    XCTAssertNil(savedValue)
  }

  func test_property_값을_전달하면_userDefaults에_저장해요() {
    // given
    let inputValue = "test"

    // when
    @Property(key: "userName", defaultValue: nil, diskCache: self.diskCache)
    var value: String?
    let result = value

    value = inputValue

    // then
    XCTAssertNil(result)
    XCTAssertEqual(value, inputValue)
  }

  func test_property_값을_변경하면_userDefaults에_저장해요() {
    // given
    let inputValue = "test"

    // when
    @Property(key: "userName", defaultValue: "foo", diskCache: self.diskCache)
    var value: String
    let result = value

    value = inputValue

    // then
    XCTAssertEqual(result, "foo")
    XCTAssertEqual(value, inputValue)

    let savedValue: String? = self.userDefaults.string(forKey: "userName")
    XCTAssertEqual(savedValue, inputValue)
  }

  func test_property_값을_nil로_변경하면_userDefaults에서_제거해요() {
    // given
    let inputValue1 = "test"
    let inputValue2: String? = nil

    // when
    @Property(key: "userName", defaultValue: nil, diskCache: self.diskCache)
    var value: String?

    value = inputValue1
    let result = value

    value = inputValue2

    // then
    XCTAssertEqual(result, inputValue1)
    XCTAssertNil(value)

    let savedValue: String? = self.userDefaults.string(forKey: "userName")
    XCTAssertNil(savedValue)
  }
}

// MARK: Observable Property

extension DiskCacheContainerTests {

  func test_property_값을_변경하면_Observable로_방출해요() async throws {
    // given
    let inputValues = [
      "test1",
      "test2",
      "test3"
    ]

    // when
    @Property(key: "userName", defaultValue: nil, diskCache: self.diskCache)
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

// MARK: CodableProperty

extension DiskCacheContainerTests {

  func test_codableProperty_저장되어_있는_값이_없을때_호출하면_기본값으로_nil을_반환해요() {
    // when
    @CodableProperty(key: "dummy", defaultValue: nil, diskCache: self.diskCache)
    var value: CodableDummy?
    let result = value

    // then
    XCTAssertNil(result)

    let savedValue: CodableDummy? = self.userDefaults.codable(for: "dummy")
    XCTAssertNil(savedValue)
  }

  func test_codableProperty_값을_전달하면_userDefaults에_저장해요() {
    // given
    let inputValue = ["test": CodableDummy(string: "값")]

    // when
    @CodableProperty(key: "dummy", defaultValue: [:], diskCache: self.diskCache)
    var value: [String: CodableDummy]
    let result = value

    value = inputValue

    // then
    XCTAssertTrue(result.isEmpty)

    XCTAssertEqual(value, inputValue)
    XCTAssertEqual(value["test"]?.string, "값")
  }

  func test_codableProperty_dummy값을_변경하면_userDefaults에_저장해요() {
    // given
    let inputValue = CodableDummy(string: "test")

    // when
    @CodableProperty(key: "dummy", defaultValue: nil, diskCache: self.diskCache)
    var value: CodableDummy?
    let result = value

    value = inputValue

    // then
    XCTAssertNil(result)
    XCTAssertEqual(value, inputValue)

    let savedValue: CodableDummy? = self.userDefaults.codable(for: "dummy")
    XCTAssertEqual(savedValue, inputValue)
  }

  func test_codableProperty_dummy값을_nil로_변경하면_userDefaults에서_제거해요() {
    // given
    let inputValue1 = CodableDummy(string: "test")
    let inputValue2: CodableDummy? = nil

    // when
    @CodableProperty(key: "dummy", defaultValue: nil, diskCache: self.diskCache)
    var value: CodableDummy?
    value = inputValue1
    let result = value

    value = inputValue2

    // then
    XCTAssertEqual(result, inputValue1)
    XCTAssertNil(value)

    let savedValue: CodableDummy? = self.userDefaults.codable(for: "dummy")
    XCTAssertNil(savedValue)
  }
}
