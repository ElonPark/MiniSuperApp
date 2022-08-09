//
//  BaseViewController.swift
//
//
//  Created by Elon on 2022/08/07.
//

import UIKit

open class BaseViewController: UIViewController {

  // MARK: - Initialization & Deinitialization

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("deinit \(type(of: self))")
  }
}
