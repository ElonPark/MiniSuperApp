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
      self.layer.cornerRadius = newValue
      self.setNeedsLayout()
    }
  }

  var cornerCurve: CALayerCornerCurve = .continuous {
    willSet {
      self.layer.cornerCurve = newValue
      self.setNeedsLayout()
    }
  }

  var borderColor: UIColor = .clear {
    willSet {
      self.layer.borderColor = newValue.cgColor
      self.setNeedsLayout()
    }
  }

  var borderWidth: CGFloat = .zero {
    willSet {
      self.layer.borderWidth = newValue
      self.setNeedsLayout()
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
    self.layer.cornerRadius = cornerRadius
    self.layer.cornerCurve = cornerCurve
    self.layer.borderColor = borderColor.cgColor
    self.layer.borderWidth = borderWidth
  }

  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    self.traitCollection.performAsCurrent {
      self.layer.borderColor = self.borderColor.cgColor
    }
  }
}
