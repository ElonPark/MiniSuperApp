//
//  LoggedOutViewController.swift
//  LoggedOutSample
//
//  Created by Elon on 2022/09/18.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import UIKit

import RIBs
import RxSwift

import DesignSystem

// MARK: - LoggedOutPresentableListener

protocol LoggedOutPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

// MARK: - LoggedOutViewController

final class LoggedOutViewController:
  BaseViewController,
  LoggedOutPresentable,
  LoggedOutViewControllable
{

  weak var listener: LoggedOutPresentableListener?

  override init() {
    super.init()
    self.modalPresentationStyle = .fullScreen
    self.modalTransitionStyle = .crossDissolve
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // FIXME: - 수정 필요 <Elon> 2022-09-18 02:52:42
    self.view.backgroundColor = .brown
  }
}
