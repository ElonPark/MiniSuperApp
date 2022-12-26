//
//  LoggedOutInteractorTests.swift
//  LoggedOutSample
//
//  Created by Elon on 2022/09/18.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import XCTest

@testable import LoggedOut

final class LoggedOutInteractorTests: XCTestCase {

  private var presenter: LoggedOutPresentableMock!
  private var router: LoggedOutRoutingMock!
  private var listener: LoggedOutListenerMock!
  private var interactor: LoggedOutInteractor!

  override func setUpWithError() throws {
    try super.setUpWithError()
    presenter = .init()
    router = .init()
    listener = .init()
    interactor = LoggedOutInteractor(
      presenter: presenter
    )

    interactor.router = router
    interactor.listener = listener
  }

  // MARK: - Tests

  func test_sendSignUpAction이_호출되면_라우터에_attachSignUpFlowRIB을_호출해요() {
    // given
    let action = LoggedOutModels.SignUp.Action.buttonClicked

    // when
    interactor.sendSignUpAction(action)

    // then
    XCTAssertEqual(router.attachSignUpFlowRIBCallCount, 1)
  }

  func test_sendSignInAction이_호출되면_라우터에_attachSignInFlowRIB을_호출해요() {
    // given
    let action = LoggedOutModels.SignIn.Action.buttonClicked

    // when
    interactor.sendSignInAction(action)

    // then
    XCTAssertEqual(router.attachSignInFlowRIBCallCount, 1)
  }
}
