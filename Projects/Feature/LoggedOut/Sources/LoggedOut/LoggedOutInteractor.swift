//
//  LoggedOutInteractor.swift
//  LoggedOutSample
//
//  Created by Elon on 2022/09/18.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import RIBs
import RxSwift

import LoggedOutInterface

// MARK: - LoggedOutPresentable

protocol LoggedOutPresentable: Presentable {
  var listener: LoggedOutPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

// MARK: - LoggedOutInteractor

final class LoggedOutInteractor:
  PresentableInteractor<LoggedOutPresentable>,
  LoggedOutInteractable,
  LoggedOutPresentableListener
{

  weak var router: LoggedOutRouting?
  weak var listener: LoggedOutListener?

  override init(presenter: LoggedOutPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }


  func sendSignUpAction(_ action: LoggedOutModels.SignUp.Action) {

  }

  func sendSignInAction(_ action: LoggedOutModels.SignIn.Action) {
    
  }
}
