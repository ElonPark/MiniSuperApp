// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

/// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// MARK: - Asset

// swiftlint:disable superfluous_disable_command file_length implicit_return

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Color {
    public enum Semantic {
      public static var gray: ColorAsset.Color { ColorAsset(name: "Gray").color }
      public static var label: ColorAsset.Color { ColorAsset(name: "Label").color }
      public static var primary: ColorAsset.Color { ColorAsset(name: "Primary").color }
      public static var secondaryBackground: ColorAsset.Color { ColorAsset(name: "SecondaryBackground").color }
      public static var background: ColorAsset.Color { ColorAsset(name: "background").color }
    }

    public enum Static {
      public static var blue: ColorAsset.Color { ColorAsset(name: "Blue").color }
      public static var red: ColorAsset.Color { ColorAsset(name: "Red").color }
      public static var white: ColorAsset.Color { ColorAsset(name: "white").color }
    }
  }

  public enum Image {
    public enum Icon {
      public static var addCircleFill: ImageAsset.Image { ImageAsset(name: "add_circle_fill").image }
    }
  }
}

// MARK: - ColorAsset

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
    public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
    public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
      let bundle = BundleToken.bundle
      guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
        fatalError("Unable to load color asset named \(name).")
      }
      return color
    }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
      self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
      self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
      self.init(named: asset.name)
    #endif
  }
}

// MARK: - ImageAsset

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
    public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
    public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
      let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
      let name = NSImage.Name(name)
      let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
      let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
    @available(iOS 8.0, tvOS 9.0, *)
    public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
      let bundle = BundleToken.bundle
      guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
        fatalError("Unable to load image asset named \(name).")
      }
      return result
    }
  #endif
}

extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
             message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  public convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
      let bundle = BundleToken.bundle
      self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
      self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
      self.init(named: asset.name)
    #endif
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
