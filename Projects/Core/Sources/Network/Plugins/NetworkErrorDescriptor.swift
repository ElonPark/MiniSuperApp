//
//  NetworkErrorDescriptor.swift
//
//
//  Created by Elon on 2022/07/22.
//

import Foundation

import Alamofire
import Moya

struct NetworkErrorDescriptor {

  // MARK: Properties

  private var moyaError: MoyaError? { error as? MoyaError }

  private var moyaUnderlyingError: Error? {
    guard case let .underlying(underlyingError, _) = moyaError else { return nil }
    return underlyingError
  }

  private var isMoyaUnderlyingError: Bool { moyaUnderlyingError != nil }

  private var afError: AFError? {
    guard let moyaUnderlyingError else { return error.asAFError }
    return moyaUnderlyingError.asAFError
  }

  private var afUnderlyingError: Error? { afError?.underlyingError }

  private var urlError: URLError? {
    if let urlError = error as? URLError {
      return urlError
    }
    return afUnderlyingError as? URLError
  }

  private let error: Error

  // MARK: Initializing

  init(error: Error) {
    self.error = error
  }

  func errorLogMessage() -> String {
    guard let moyaError else { return error.localizedDescription }

    var messages = [String]()

    if !isMoyaUnderlyingError, let errorDescription = moyaError.errorDescription {
      messages.append("Moya Error Description: \(errorDescription)")
    }

    messages.append(afErrorDebugDescriptions().joined(separator: "\n"))
    messages.append(urlErrorDebugDescriptions().joined(separator: "\n"))

    if let responseString = responseString() {
      messages.append(responseString)
    }

    return messages.filter { !$0.isEmpty }.joined(separator: "\n")
  }

  private func afErrorDebugDescriptions() -> [String] {
    guard let afError else { return [] }

    var messages = [String]()

    if let responseCode = afError.responseCode {
      messages.append("Response Code: \(responseCode)")
    }
    if let responseContentType = afError.responseContentType {
      messages.append("Response Content Type: \(responseContentType)")
    }
    if let failureReason = afError.failureReason {
      messages.append("Failure Reason: \(failureReason)")
    }
    if let recoverySuggestion = afError.recoverySuggestion {
      messages.append("Recovery Suggestion: \(recoverySuggestion)")
    }
    if let contentType = afError.responseContentType {
      messages.append("Content Type: \(contentType)")
    }
    if let errorDescription = afError.errorDescription {
      messages.append("Description: \(errorDescription)")
    }

    return messages
  }

  private func urlErrorDebugDescriptions() -> [String] {
    guard let urlError else { return [] }

    var messages = [String]()

    if let urlString = urlError.failureURLString {
      messages.append("Failure URLString: \(urlString)")
    }

    return messages
  }

  private func responseString() -> String? {
    guard let response = moyaError?.response else { return nil }
    do {
      let json = try JSONSerialization.jsonObject(with: response.data)
      let prettyJSONData = try JSONSerialization.data(
        withJSONObject: json,
        options: .prettyPrinted
      )

      if let prettyJSON = String(data: prettyJSONData, encoding: .utf8) {
        return prettyJSON
      }

      return String(data: response.data, encoding: .utf8)
    } catch {
      return String(data: response.data, encoding: .utf8)
    }
  }
}
