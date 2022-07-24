//
//  DataLoader+Extensions.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

extension DataLoader {
  func createAccount(
    login: String,
    password: String,
    age: Int,
    isNotifyNews: Bool,
    isNotifyCabinet: Bool
  ) async throws {
    let url = try createUrl(host: .staging, path: "api/v1/account/create")

    let headers: [HTTPHeader] = [
      .contentType("application/json")
    ]

    let parameters: Request.Query = [
      "method": "createUser",
      "credentials": [
        "login": login,
        "password": password,
        "age": age,
        "notificationSettings": [
          "notifyNews": isNotifyNews,
          "notifyCabinet": isNotifyCabinet
        ]
      ]
    ]

    try await dataRequest(
      url: url,
      method: .post,
      headers: headers,
      parameters: .body(parameters)
    )
  }
}
