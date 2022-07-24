//
//  HTTPMethod.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

// MARK: - HTTPMethod

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}

extension HTTPMethod {
  public static let connect = HTTPMethod(rawValue: "CONNECT")
  public static let delete = HTTPMethod(rawValue: "DELETE")
  public static let get = HTTPMethod(rawValue: "GET")
  public static let head = HTTPMethod(rawValue: "HEAD")
  public static let options = HTTPMethod(rawValue: "OPTIONS")
  public static let patch = HTTPMethod(rawValue: "PATCH")
  public static let post = HTTPMethod(rawValue: "POST")
  public static let put = HTTPMethod(rawValue: "PUT")
  public static let trace = HTTPMethod(rawValue: "TRACE")
  public static let query = HTTPMethod(rawValue: "QUERY")
}
