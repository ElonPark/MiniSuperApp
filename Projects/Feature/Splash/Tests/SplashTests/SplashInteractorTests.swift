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
    presenter = .init()
    repository = .init()
    router = .init()
    listener = .init()
    interactor = SplashInteractor(
      presenter: presenter,
      bootstrapRepository: repository
    )

    interactor.router = router
    interactor.listener = listener
  }

  // MARK: - Tests

  func test_didBecomeActive가_호출되면_repository에_bootstrapping을_요청해요() {
    // given
    repository.requestBootstrappingHandler = { .just(Void()) }

    // when
    interactor.didBecomeActive()

    // then
    XCTAssertEqual(repository.requestBootstrappingCallCount, 1)
  }

  func test_didBecomeActive_호출시_bootstrapping을_요청_전후로_presenter에_displaySplash를_호출해요() {
    // given
    enum History: Equatable {
      case isLoading(Bool)
      case bootstrapping
    }
    var callHistory = [History]()

    presenter.displaySplashHandler = {
      callHistory.append(.isLoading($0.isLoading))
    }
    repository.requestBootstrappingHandler = {
      callHistory.append(.bootstrapping)
      return .just(Void())
    }

    // when
    interactor.didBecomeActive()

    // then
    XCTAssertEqual(presenter.displaySplashCallCount, 2)
    XCTAssertEqual(repository.requestBootstrappingCallCount, 1)
    XCTAssertEqual(callHistory[0], History.isLoading(true))
    XCTAssertEqual(callHistory[1], History.bootstrapping)
    XCTAssertEqual(callHistory[2], History.isLoading(false))
  }

  func test_bootstrapping을_요청_성공시_listener에_initializationComplete를_호출해요() {
    // given
    repository.requestBootstrappingHandler = { .just(Void()) }

    // when
    interactor.didBecomeActive()

    // then
    XCTAssertEqual(listener.initializationCompleteCallCount, 1)
  }

  func test_bootstrapping을_요청_실패시_presenter에_displayBootstrap를_호출해요() {
    // given
    repository.requestBootstrappingHandler = { .error(URLError(.badServerResponse)) }

    // when
    interactor.didBecomeActive()

    // then
    XCTAssertEqual(presenter.displayBootstrapCallCount, 1)
  }
}
