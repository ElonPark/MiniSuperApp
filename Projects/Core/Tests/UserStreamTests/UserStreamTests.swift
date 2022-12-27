//
//  UserStreamTests.swift
//
//
//  Created by Elon on 2022/09/12.
//

import XCTest

import AppTestSupport
import Platform
import UserStreamInterface
@testable import UserStream

// MARK: - UserStreamTests

final class UserStreamTests: XCTestCase {

  var userDefaults: UserDefaultsStub!
  var userStream: UserStreamImpl!

  override func setUpWithError() throws {
    try super.setUpWithError()
    userDefaults = UserDefaultsStub()
    userStream = UserStreamImpl(userDefaults: userDefaults)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
    userDefaults = nil
    userStream = nil
  }
}

// MARK: UserStream

extension UserStreamTests {

  func test_user을_호출하면_기본값으로_nil을_반환해요() {
    // given
    userDefaults = UserDefaultsStub()

    // when
    let result = userStream.user

    // then
    XCTAssertNil(result)
  }

  func test_setUser에_user객체_전달시() {
    // given: 파라미터로 유저를
    let user = User(id: 0, name: "test")

    // when: userStream에 user를 전달하면
    userStream.configure(user: user)

    // then: user프로퍼티를 업데이트해요.
    XCTAssertEqual(userStream.user?.id, 0)
    XCTAssertEqual(userStream.user?.name, "test")
  }

  func test_setUser에_nil_전달시() {
    // given: 파라미터로 nil을
    let user: User? = nil
    userDefaults.setCodable(value: User(id: 0, name: "test"), forKey: "currentUser")

    // when: userStream.user에 nil을 전달하면
    userStream.configure(user: user)

    // then: user프로퍼티를 nil로 변경해요.
    let savedValue: User? = userDefaults.codable(forKey: "currentUser")
    XCTAssertNil(savedValue)
  }

  func test_user값을_변경하면_diskCache에_저장해요() {
    // given
    let user = User(id: 999, name: "test")

    // when
    userStream.configure(user: user)

    // then
    XCTAssertEqual(userStream.user?.id, 999)
    XCTAssertEqual(userStream.user?.name, "test")

    let savedValue: User? = userDefaults.codable(forKey: "currentUser")
    XCTAssertEqual(savedValue?.id, 999)
    XCTAssertEqual(savedValue?.name, "test")
  }
}
