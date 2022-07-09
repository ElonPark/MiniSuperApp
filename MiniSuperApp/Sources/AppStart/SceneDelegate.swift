//
//  SceneDelegate.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/01/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let _ = (scene as? UIWindowScene) else { return }
  }
}
