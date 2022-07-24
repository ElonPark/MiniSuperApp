//
//  Request.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

public final class Request {

  // MARK: - Properties

  private(set) var urlRequest: URLRequest

  // MARK: - Lifecycle

  init(
    url: URL,
    method: HTTPMethod,
    headers: [HTTPHeader],
    parameters: Parameters?
  ) throws {
    self.urlRequest = URLRequest(url: url)
    self.urlRequest.httpMethod = method.rawValue
    self.urlRequest.allHTTPHeaderFields = headers.reduce(into: [:]) { $0[$1.name] = $1.value }

    if let parameters {
      switch parameters.destination {
      case .query:
        guard let (query, encoding) = parameters.object as? (Query<String>, QueryEncoding) else {
          throw "Cannot resolve query object"
        }

        self.urlRequest.url = query.encode(to: url, encoding: encoding)
      case .body:
        guard let data = parameters.object as? Data else {
          throw "Cannot resolve data object"
        }

        self.urlRequest.httpBody = data
      }
    }
  }
}
