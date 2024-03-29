// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - L10n

// swiftlint:disable superfluous_disable_command file_length implicit_return

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Common {
    /// Common/Cancel: `취소`
    public static let cancel = L10n.tr("Localizable", "Common/Cancel")
    /// Common/Hour: `Plural format key: "%#@format@"`
    public static func hour(_ p1: Int) -> String {
      return L10n.tr("Localizable", "Common/Hour", p1)
    }

    /// Common/Ok: `확인`
    public static let ok = L10n.tr("Localizable", "Common/Ok")
  }

  public enum LoggedOut {
    /// LoggedOut/SignIn: `로그인`
    public static let signIn = L10n.tr("Localizable", "LoggedOut/SignIn")
    /// LoggedOut/SignUp: `회원가입`
    public static let signUp = L10n.tr("Localizable", "LoggedOut/SignUp")
  }

  public enum Splash {
    /// Splash/Greeting: `안녕하세요`
    public static let greeting = L10n.tr("Localizable", "Splash/Greeting")
  }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// MARK: - BundleToken

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
      return Bundle.module
    #else
      return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type
