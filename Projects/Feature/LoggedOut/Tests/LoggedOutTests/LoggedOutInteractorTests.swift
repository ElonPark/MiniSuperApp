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
    self.presenter = .init()
    self.router = .init()
    self.listener = .init()
    self.interactor = LoggedOutInteractor(
      presenter: self.presenter
    )

    self.interactor.router = self.router
    self.interactor.listener = self.listener
  }

  // MARK: - Tests

  func test_sendSignUpAction이_호출되면_라우터에_attachSignUpFlowRIB을_호출해요() {
    // given
    let action = LoggedOutModels.SignUp.Action.buttonClicked

    // when
    self.interactor.sendSignUpAction(action)

    // then
    XCTAssertEqual(self.router.attachSignUpFlowRIBCallCount, 1)
  }

  func test_sendSignInAction이_호출되면_라우터에_attachSignInFlowRIB을_호출해요() {
    // given
    let action = LoggedOutModels.SignIn.Action.buttonClicked

    // when
    self.interactor.sendSignInAction(action)

    // then
    XCTAssertEqual(self.router.attachSignInFlowRIBCallCount, 1)
  }
}
