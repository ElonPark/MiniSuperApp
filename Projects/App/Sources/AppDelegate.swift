import UIKit

import AppResource

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = UIViewController()
    viewController.view.backgroundColor = Asset.Color.Static.red
    self.window?.rootViewController = viewController
    self.window?.makeKeyAndVisible()

    return true
  }
}
