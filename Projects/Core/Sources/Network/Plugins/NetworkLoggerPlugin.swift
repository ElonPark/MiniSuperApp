//
//  NetworkLoggerPlugin.swift
//
//
//  Created by Elon on 2022/07/22.
//

import Foundation

import Moya

public final class NetworkLoggerPlugin: PluginType {

  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss.SSS"
    return formatter
  }()

  public func willSend(_ request: RequestType, target: TargetType) {
    let url = URL(string: target.path, relativeTo: target.baseURL)
    let requestString = "\(target.method.rawValue) \(url?.absoluteString ?? target.path)"
    print("⚡️ REQUEST: \(requestString)")
  }

  public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
    let url = URL(string: target.path, relativeTo: target.baseURL)
    let requestString = "\(target.method.rawValue) \(url?.absoluteString ?? target.path)"

    switch result {
    case let .success(response):
      print("✅ SUCCESS: \(requestString) (\(response.description))")

    case let .failure(error):
      let networkErrorDescriptor = NetworkErrorDescriptor(error: error)
      print("🚨 FAILURE: \(requestString)\n\(networkErrorDescriptor.errorLogMessage())")
    }
  }
}
