//
//  Request+Parameters.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

extension Request {
  public struct Parameters {

    // MARK: - Types

    public enum Destination {
      case query
      case body
    }

    // MARK: - Properties

    let destination: Destination
    let object: Any

    // MARK: - Methods

    public static func query(_ query: Query<String>, encoding: QueryEncoding? = nil) -> Parameters {
      let encoding = encoding ?? QueryEncoding()
      let object = (query, encoding)
      return Parameters(destination: .query, object: object)
    }

    public static func body<T: Encodable>(_ object: T, encoder: JSONEncoder? = nil) throws -> Parameters {
      let encoder = encoder ?? JSONEncoder()
      let data = try encoder.encode(object)
      return Parameters(destination: .body, object: data)
    }

    public static func body(_ data: Data) -> Parameters {
      return Parameters(destination: .body, object: data)
    }
  }
}
