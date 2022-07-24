//
//  NetworkManager.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

public class NetworkManager {

  // MARK: - Properties

  let session: URLSession

  // MARK: - Lifecycle

  public init(session: URLSession) {
    self.session = session
  }

  // MARK: - Methods

  func handle<T>(response: URLResponse, content: T) throws -> T {
    guard let response = response as? HTTPURLResponse else {
      throw URLError(.cannotParseResponse) // "Unknown response received"
    }

    guard let httpStatusCode = HttpStatusCode(rawValue: response.statusCode) else {
      throw "Unknown http status code"
    }

    if httpStatusCode.isSuccessStatusCode {
      return content
    } else if let content = content as? Data {
      throw try JSONDecoder().decode(Request.Error.self, from: content)
    } else {
      throw Request.Error(code: response.statusCode)
    }
  }
}
