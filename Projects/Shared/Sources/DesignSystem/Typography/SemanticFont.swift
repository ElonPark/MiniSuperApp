//
//  SemanticFont.swift
//
//
//  Created by Elon on 2022/08/07.
//

import Foundation
import UIKit

public enum SemanticFont {
  public static var largeTitle = Self.preferredFont(.largeTitle)
  public static var title1 = Self.preferredFont(.title1)
  public static var title2 = Self.preferredFont(.title2)
  public static var title3 = Self.preferredFont(.title3)
  public static var headline = Self.preferredFont(.headline)
  public static var subhead = Self.preferredFont(.subheadline)
  public static var body = Self.preferredFont(.body)
  public static var callout = Self.preferredFont(.callout)
  public static var footnote = Self.preferredFont(.footnote)
  public static var caption1 = Self.preferredFont(.caption1)
  public static var caption2 = Self.preferredFont(.caption2)

  static func preferredFont(_ textStyle: UIFont.TextStyle) -> UIFont {
    return UIFont.preferredFont(forTextStyle: textStyle)
  }
}
