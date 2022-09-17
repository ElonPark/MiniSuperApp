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

// MARK: - LoggedOutPresentableListener

protocol LoggedOutPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

// MARK: - LoggedOutViewController

final class LoggedOutViewController:
  UIViewController,
  LoggedOutPresentable,
  LoggedOutViewControllable
{
  weak var listener: LoggedOutPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    // FIXME: - 수정 필요 <Elon> 2022-09-18 02:52:42
    self.view.backgroundColor = .brown
  }
}
