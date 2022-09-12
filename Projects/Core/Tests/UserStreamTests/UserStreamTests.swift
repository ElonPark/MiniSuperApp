//
//  UserStreamTests.swift
//
//
//  Created by Elon on 2022/09/12.
//

import XCTest

import AppTestSupport
import Platform
@testable import UserStream
import UserStreamInterface

// MARK: - UserStreamTests

final class UserStreamTests: XCTestCase {

  var diskCache: DiskCache!
  var userStream: UserStreamImpl!

  override func setUpWithError() throws {
    try super.setUpWithError()
    self.diskCache = DiskCache(container: UserDefaultsStub())
    self.userStream = UserStreamImpl(diskCache: self.diskCache)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
    self.diskCache = nil
    self.userStream = nil
  }
}

// MARK: UserStream

extension UserStreamTests {

  func test_user을_호출하면_기본값으로_nil을_반환해요() {
    // when
    let result = self.userStream.user

    // then
    XCTAssertNil(result)
  }

  func test_setUser에_user객체_전달시() {
    // given: 파라미터로 유저를
    let user = User(id: 0, name: "test")

    // when: setUser에_전달하면
    self.userStream.setUser(user)

    // then: user프로퍼티를 업데이트해요.
    XCTAssertEqual(self.userStream.user, user)
  }

  func test_setUser에_nil_전달시() {
    // given: 파라미터로 nil을
    let user: User? = nil

    // when: setUser에_전달하면
    self.userStream.setUser(user)

    // then: user프로퍼티를 nil로 변경해요.
    XCTAssertNil(self.userStream.user)
  }

  func test_user값을_변경하면_diskCache에_저장해요() {
    // given
    let inputValue = User(id: 999, name: "test")

    // when
    self.userStream.setUser(inputValue)

    // then
    XCTAssertEqual(self.userStream.user, inputValue)

    let savedValue: User? = self.diskCache.container.codable(for: "currentUser")
    XCTAssertEqual(savedValue, inputValue)
  }
}
