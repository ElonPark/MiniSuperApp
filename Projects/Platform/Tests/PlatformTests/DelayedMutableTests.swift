//
//  DelayedMutableTests.swift
//
//
//  Created by Elon on 2022/07/21.
//

import Foundation
import XCTest

@testable import Platform

final class DelayedMutableTests: XCTestCase {

  private struct Dummy {
    @DelayedMutable
    var value: String

    init() {}
  }

  func test_변수_초기화를_딜레이할_수_있어요() {
    // given
    var dummy = Dummy()

    // when
    dummy.value = "hello"

    // then
    XCTAssertEqual(dummy.value, "hello")
  }

  func test_변수_초기화를_딜레이하고_다른_값을_할당할_수_있어요() {
    // given
    var dummy = Dummy()

    // when
    dummy.value = "hello"
    let result1 = dummy.value

    dummy.value = "world"
    let result2 = dummy.value

    // then
    XCTAssertEqual(result1, "hello")
    XCTAssertEqual(result2, "world")
  }
}
