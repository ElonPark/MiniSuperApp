//
//  DataLoader.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

public final class DataLoader: NetworkManager {
  @discardableResult
  public func dataRequest<T: Decodable>(
    url: URL,
    method: HTTPMethod,
    headers: [HTTPHeader] = [],
    parameters: Request.Parameters? = nil,
    decoder: JSONDecoder? = nil
  ) async throws -> T {
    let data = try await dataRequest(
      url: url,
      method: method,
      headers: headers,
      parameters: parameters
    )

    let decoder = decoder ?? JSONDecoder()
    return try decoder.decode(T.self, from: data)
  }

  @discardableResult
  public func dataRequest(
    url: URL,
    method: HTTPMethod,
    headers: [HTTPHeader] = [],
    parameters: Request.Parameters? = nil
  ) async throws -> Data {
    let request = try Request(
      url: url,
      method: method,
      headers: headers,
      parameters: parameters
    )

    let (data, response) = try await session.data(for: request.urlRequest)
    return try handle(response: response, content: data)
  }
}
