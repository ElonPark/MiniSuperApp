import UIKit

import RIBs

import AppFoundation

// MARK: - AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  private var launchRouter: LaunchRouting?
  private var urlHandler: URLHandler?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    registerProviderFactories()
    configureAppLaunch()

    return true
  }
}

extension AppDelegate {
  private func configureAppLaunch() {
    let appComponent = AppComponent()
    let rootBuilder = appComponent.rootBuilder
    (launchRouter, urlHandler) = rootBuilder.build()

    configureWindowWithLaunch()
  }

  private func configureWindowWithLaunch() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    launchRouter?.launch(from: window)
  }
}
