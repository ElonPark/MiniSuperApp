//
//  QueryEncoding.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

public struct QueryEncoding {
  public enum ArrayEncoding {
    case enclosingBrackets
    case surroundingBrackets
    case noBrackets
  }

  public enum BoolEncoding {
    case numeric
    case literal
  }

  public var array: ArrayEncoding
  public var bool: BoolEncoding

  public init(
    array: QueryEncoding.ArrayEncoding = .enclosingBrackets,
    bool: QueryEncoding.BoolEncoding = .literal
  ) {
    self.array = array
    self.bool = bool
  }
}
