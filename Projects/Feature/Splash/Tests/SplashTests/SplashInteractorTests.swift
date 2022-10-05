//
//  SplashInteractorTests.swift
//  SplashSample
//
//  Created by Elon on 2022/08/07.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import XCTest

@testable import Splash

final class SplashInteractorTests: XCTestCase {

  private var presenter: SplashPresentableMock!
  private var repository: BootstrapRepositoryMock!
  private var router: SplashRoutingMock!
  private var listener: SplashListenerMock!
  private var interactor: SplashInteractor!

  override func setUpWithError() throws {
    try super.setUpWithError()
    self.presenter = .init()
    self.repository = .init()
    self.router = .init()
    self.listener = .init()
    self.interactor = SplashInteractor(
      presenter: self.presenter,
      bootstrapRepository: self.repository
    )

    self.interactor.router = self.router
    self.interactor.listener = self.listener
  }

  // MARK: - Tests

  func test_didBecomeActive가_호출되면_repository에_bootstrapping을_요청해요() {
    // given
    self.repository.requestBootstrappingHandler = { .just(Void()) }

    // when
    self.interactor.didBecomeActive()

    // then
    XCTAssertEqual(self.repository.requestBootstrappingCallCount, 1)
  }

  func test_didBecomeActive_호출시_bootstrapping을_요청_전후로_presenter에_displaySplash를_호출해요() {
    // given
    enum History: Equatable {
      case isLoading(Bool)
      case bootstrapping
    }
    var callHistory = [History]()

    self.presenter.displaySplashHandler = {
      callHistory.append(.isLoading($0.isLoading))
    }
    self.repository.requestBootstrappingHandler = {
      callHistory.append(.bootstrapping)
      return .just(Void())
    }

    // when
    self.interactor.didBecomeActive()

    // then
    XCTAssertEqual(self.presenter.displaySplashCallCount, 2)
    XCTAssertEqual(self.repository.requestBootstrappingCallCount, 1)
    XCTAssertEqual(callHistory[0], History.isLoading(true))
    XCTAssertEqual(callHistory[1], History.bootstrapping)
    XCTAssertEqual(callHistory[2], History.isLoading(false))
  }

  func test_bootstrapping을_요청_성공시_listener에_initializationComplete를_호출해요() {
    // given
    self.repository.requestBootstrappingHandler = { .just(Void()) }

    // when
    self.interactor.didBecomeActive()

    // then
    XCTAssertEqual(self.listener.initializationCompleteCallCount, 1)
  }

  func test_bootstrapping을_요청_실패시_presenter에_displayBootstrap를_호출해요() {
    // given
    self.repository.requestBootstrappingHandler = { .error(URLError(.badServerResponse)) }

    // when
    self.interactor.didBecomeActive()

    // then
    XCTAssertEqual(self.presenter.displayBootstrapCallCount, 1)
  }
}
