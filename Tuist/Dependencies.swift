import DependencyPlugin
import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: SwiftPackageManagerDependencies(
    ExternalDependency.packages,
    productTypes: ExternalDependency.productTypes
  ),
  platforms: [.iOS]
)
