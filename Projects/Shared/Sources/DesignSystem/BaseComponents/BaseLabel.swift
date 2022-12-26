//
//  BaseLabel.swift
//
//
//  Created by Elon on 2022/08/07.
//

import UIKit

open class BaseLabel: UILabel {

  // MARK: - Initialization & Deinitialization

  override public init(frame: CGRect) {
    super.init(frame: frame)
    adjustsFontForContentSizeCategory = true
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
