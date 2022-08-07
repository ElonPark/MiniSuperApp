//
//  BootstrapAPI.swift
//
//
//  Created by Elon on 2022/08/08.
//

import Foundation

import Moya

// MARK: - BootstrapAPI

enum BootstrapAPI {
  case bootstrapping
}

// MARK: - TargetType

extension BootstrapAPI: TargetType {

  var baseURL: URL {
    URL(string: "localhost")!
  }

  var path: String {
    "/"
  }

  var method: Moya.Method {
    .get
  }

  var task: Task {
    .requestPlain
  }

  var headers: [String: String]? {
    nil
  }
}
