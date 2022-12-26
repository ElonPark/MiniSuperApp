//
//  RootRouterTests.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/22.
//  Copyright © 2022 elonpark. All rights reserved.
//

import Foundation
import XCTest

import SplashTestSupport
@testable import MiniSuperApp

final class RootRouterTests: XCTestCase {

  private var interactor: RootInteractableMock!
  private var viewController: RootViewControllableMock!
  private var splashBuilder: SplashBuildableMock!
  private var router: RootRouter!

  override func setUpWithError() throws {
    try super.setUpWithError()
    interactor = .init()
    viewController = .init()
    splashBuilder = .init()

    router = RootRouter(
      interactor: interactor,
      viewController: viewController,
      splashBuilder: splashBuilder
    )
  }

  // MARK: - Tests

  func test_attachSplashRIB() {
    // when
    router.attachSplashRIB()

    // then
    XCTAssertNotNil(router.splashRouter)
    XCTAssertEqual(splashBuilder.buildCallCount, 1)
    XCTAssertEqual(viewController.presentCallCount, 1)
  }

  func test_detachSplashRIB() {
    // given
    router.attachSplashRIB()

    // when
    router.detachSplashRIB()

    // then
    XCTAssertNil(router.splashRouter)
    XCTAssertEqual(viewController.dismissCallCount, 1)
  }
}
