//
//  RootRouterTests.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/22.
//  Copyright © 2022 elonpark. All rights reserved.
//

import Foundation
import XCTest

@testable import MiniSuperApp
import SplashTestSupport

final class RootRouterTests: XCTestCase {

  private var interactor: RootInteractableMock!
  private var viewController: RootViewControllableMock!
  private var splashBuilder: SplashBuildableMock!
  private var router: RootRouter!

  override func setUpWithError() throws {
    try super.setUpWithError()
    self.interactor = .init()
    self.viewController = .init()
    self.splashBuilder = .init()

    self.router = RootRouter(
      interactor: self.interactor,
      viewController: self.viewController,
      splashBuilder: self.splashBuilder
    )
  }

  // MARK: - Tests

  func test_attachSplashRIB() {
    // when
    self.router.attachSplashRIB()

    // then
    XCTAssertNotNil(self.router.splashRouter)
    XCTAssertEqual(self.splashBuilder.buildCallCount, 1)
    XCTAssertEqual(self.viewController.presentCallCount, 1)
  }

  func test_detachSplashRIB() {
    // when
    self.router.detachSplashRIB()

    // then
    XCTAssertNil(self.router.splashRouter)
    XCTAssertEqual(self.viewController.presentCallCount, 1)
  }
}
