//
//  CornerRoundedButton.swift
//
//
//  Created by elon on 2022/10/02.
//

import UIKit

open class CornerRoundedButton: UIButton {

  // MARK: Properties

  var cornerRadius: CGFloat = 0.5 {
    willSet {
      layer.cornerRadius = newValue
      setNeedsLayout()
    }
  }

  var cornerCurve: CALayerCornerCurve = .continuous {
    willSet {
      layer.cornerCurve = newValue
      setNeedsLayout()
    }
  }

  var borderColor: UIColor = .clear {
    willSet {
      layer.borderColor = newValue.cgColor
      setNeedsLayout()
    }
  }

  var borderWidth: CGFloat = .zero {
    willSet {
      layer.borderWidth = newValue
      setNeedsLayout()
    }
  }

  // MARK: Initializing

  public init(
    cornerRadius: CGFloat = 5.0,
    cornerCurve: CALayerCornerCurve = .continuous,
    borderColor: UIColor = .clear,
    borderWidth: CGFloat = .zero
  ) {
    super.init(frame: .zero)
    layer.cornerRadius = cornerRadius
    layer.cornerCurve = cornerCurve
    layer.borderColor = borderColor.cgColor
    layer.borderWidth = borderWidth
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override open func layoutSubviews() {
    super.layoutSubviews()
    traitCollection.performAsCurrent {
      self.layer.borderColor = self.borderColor.cgColor
    }
  }
}
