

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

  private class RootDependency3944cc797a4a88956fb5Provider: RootDependency {
    var splashBuilder: SplashBuildable {
      return self.appComponent.splashBuilder
    }

    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
      self.appComponent = appComponent
    }
  }

  /// ^->AppComponent->RootComponent
  private func factory264bfc4d4cb6b0629b40f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RootDependency3944cc797a4a88956fb5Provider(appComponent: parent1(component) as! AppComponent)
  }

  private class SplashDependencye0cb7136f2ec3edfd60aProvider: SplashDependency {
    var network: Networking {
      return self.appComponent.network
    }

    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
      self.appComponent = appComponent
    }
  }

  /// ^->AppComponent->SplashComponent
  private func factoryace9f05f51d68f4c0677f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SplashDependencye0cb7136f2ec3edfd60aProvider(appComponent: parent1(component) as! AppComponent)
  }

#else
  extension AppComponent: Registration {
    public func registerItems() {}
  }

  extension RootComponent: Registration {
    public func registerItems() {
      keyPathToName[\RootDependency.splashBuilder] = "splashBuilder-SplashBuildable"
    }
  }

  extension SplashComponent: Registration {
    public func registerItems() {
      keyPathToName[\SplashDependency.network] = "network-Networking"
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
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->RootComponent", factory264bfc4d4cb6b0629b40f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->SplashComponent", factoryace9f05f51d68f4c0677f47b58f8f304c97af4d5)
  }
#endif

public func registerProviderFactories() {
  #if !NEEDLE_DYNAMIC
    register1()
  #endif
}
