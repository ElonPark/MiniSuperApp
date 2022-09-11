//
//  RootInteractorTests.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/22.
//  Copyright © 2022 elonpark. All rights reserved.
//

import Foundation
import XCTest

@testable import MiniSuperApp

final class RootInteractorTests: XCTestCase {

  private var router: RootRoutingMock!
  private var presenter: RootPresentableMock!
  private var interactor: RootInteractor!

  override func setUpWithError() throws {
    try super.setUpWithError()
    self.router = .init()
    self.presenter = .init()
    self.interactor = RootInteractor(
      presenter: self.presenter
    )
    self.interactor.router = self.router
  }

  // MARK: - Tests

  func test_didBecomeActive가_호출되면_router에_attachSplashRIB를_요청해요() {
    // when
    self.interactor.didBecomeActive()

    // then
    XCTAssertEqual(self.router.attachSplashRIBCallCount, 1)
  }

  func test_initializationComplete가_호출되면_router에_attachSplashRIB를_요청해요() {
    // when
    self.interactor.initializationComplete()

    // then
    XCTAssertEqual(self.router.detachSplashRIBCallCount, 1)
  }
}
