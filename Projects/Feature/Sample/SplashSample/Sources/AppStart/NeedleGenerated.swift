

import AppFoundation
import Foundation
import NeedleFoundation
import Network
import NetworkInterface
import RIBs
import Splash
import SplashInterface

// swiftlint:disable unused_declaration
private let needleDependenciesHash: String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
  return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

  private class SplashDependencyf7dba9fd3ca54c8769deProvider: SplashDependency {
    var network: Networking {
      return self.splashSampleAppComponent.network
    }

    private let splashSampleAppComponent: SplashSampleAppComponent
    init(splashSampleAppComponent: SplashSampleAppComponent) {
      self.splashSampleAppComponent = splashSampleAppComponent
    }
  }

  /// ^->SplashSampleAppComponent->SplashComponent
  private func factory96b8d05d108c3c921819adb6edcc425671430ce1(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SplashDependencyf7dba9fd3ca54c8769deProvider(
      splashSampleAppComponent: parent1(component) as! SplashSampleAppComponent
    )
  }

  private class RootDependency2dd76bccd0c17471e840Provider: RootDependency {
    var splashBuilder: SplashBuildable {
      return self.splashSampleAppComponent.splashBuilder
    }

    private let splashSampleAppComponent: SplashSampleAppComponent
    init(splashSampleAppComponent: SplashSampleAppComponent) {
      self.splashSampleAppComponent = splashSampleAppComponent
    }
  }

  /// ^->SplashSampleAppComponent->RootComponent
  private func factorydecc7c28f0362dbe0214adb6edcc425671430ce1(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RootDependency2dd76bccd0c17471e840Provider(
      splashSampleAppComponent: parent1(component) as! SplashSampleAppComponent
    )
  }

#else
  extension SplashComponent: Registration {
    public func registerItems() {
      keyPathToName[\SplashDependency.network] = "network-Networking"
    }
  }

  extension SplashSampleAppComponent: Registration {
    public func registerItems() {}
  }

  extension RootComponent: Registration {
    public func registerItems() {
      keyPathToName[\RootDependency.splashBuilder] = "splashBuilder-SplashBuildable"
    }
  }

#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
  return EmptyDependencyProvider(component: component)
}

// MARK: - Registration

private func registerProviderFactory(
  _ componentPath: String,
  _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject
) {
  __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

  private func register1() {
    registerProviderFactory(
      "^->SplashSampleAppComponent->SplashComponent",
      factory96b8d05d108c3c921819adb6edcc425671430ce1
    )
    registerProviderFactory("^->SplashSampleAppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory(
      "^->SplashSampleAppComponent->RootComponent",
      factorydecc7c28f0362dbe0214adb6edcc425671430ce1
    )
  }
#endif

public func registerProviderFactories() {
  #if !NEEDLE_DYNAMIC
    register1()
  #endif
}
