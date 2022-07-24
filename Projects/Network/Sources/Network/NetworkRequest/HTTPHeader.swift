//
//  HTTPHeader.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

// MARK: - HTTPHeader

public struct HTTPHeader: Hashable {
  public let name: String
  public let value: String

  public init(name: String, value: String) {
    self.name = name
    self.value = value
  }
}

// MARK: - CustomStringConvertible

extension HTTPHeader: CustomStringConvertible {
  public var description: String { "\(self.name): \(self.value)" }
}

extension HTTPHeader {
  public static func accept(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Accept", value: value)
  }

  public static func acceptCharset(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Accept-Charset", value: value)
  }

  public static func acceptLanguage(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Accept-Language", value: value)
  }

  public static func acceptEncoding(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Accept-Encoding", value: value)
  }

  public static func authorization(username: String, password: String) -> HTTPHeader {
    let credential = Data("\(username):\(password)".utf8).base64EncodedString()
    return self.authorization("Basic \(credential)")
  }

  public static func authorization(bearerToken: String) -> HTTPHeader {
    self.authorization("Bearer \(bearerToken)")
  }

  public static func authorization(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Authorization", value: value)
  }

  public static func contentDisposition(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Content-Disposition", value: value)
  }

  public static func contentType(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Content-Type", value: value)
  }

  public static func contentLength(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "Content-Length", value: value)
  }

  public static func userAgent(_ value: String) -> HTTPHeader {
    HTTPHeader(name: "User-Agent", value: value)
  }
}

extension HTTPHeader {
  public static func qualityEncoded(_ encodings: [String]) -> String {
    return encodings.enumerated().map { index, encoding in
      let quality = 1.0 - (Double(index) * 0.1)
      return "\(encoding);q=\(quality)"
    }
    .joined(separator: ", ")
  }

  public static let defaultAcceptEncoding: HTTPHeader = {
    let encodings = ["br", "gzip", "deflate"]
    let value = qualityEncoded(encodings)
    return .acceptEncoding(value)
  }()

  public static let defaultAcceptLanguage: HTTPHeader = {
    let encodings = Array(Locale.preferredLanguages.prefix(6))
    let value = qualityEncoded(encodings)
    return .acceptLanguage(value)
  }()

  public static let defaultUserAgent: HTTPHeader = {
    let info = Bundle.main.infoDictionary
    let executable = (info?["CFBundleExecutable"] as? String) ??
      (ProcessInfo.processInfo.arguments.first?.split(separator: "/").last.map(String.init)) ??
      "Unknown"
    let bundle = info?["CFBundleIdentifier"] as? String ?? "Unknown"
    let appVersion = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
    let appBuild = info?["CFBundleVersion"] as? String ?? "Unknown"

    let osNameVersion: String = {
      let version = ProcessInfo.processInfo.operatingSystemVersion
      let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
      let osName: String = {
        #if os(iOS)
          #if targetEnvironment(macCatalyst)
            return "macOS(Catalyst)"
          #else
            return "iOS"
          #endif
        #elseif os(watchOS)
          return "watchOS"
        #elseif os(tvOS)
          return "tvOS"
        #elseif os(macOS)
          return "macOS"
        #elseif os(Linux)
          return "Linux"
        #elseif os(Windows)
          return "Windows"
        #else
          return "Unknown"
        #endif
      }()

      return "\(osName) \(versionString)"
    }()

    let userAgent = "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion))"
    return .userAgent(userAgent)
  }()
}
