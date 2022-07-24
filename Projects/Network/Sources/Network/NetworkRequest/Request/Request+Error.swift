//
//  Request+Error.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

extension Request {
  public struct Error: LocalizedError, Codable {
    public var code: Int
    public var error: String?

    public var statusCode: HttpStatusCode? { HttpStatusCode(rawValue: self.code) }
    public var errorDescription: String? { self.error }
  }
}
