//
//  SceneDelegate.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/01/24.
//

import UIKit

import RIBs

// MARK: - SceneDelegate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  private var launchRouter: LaunchRouting?
  private var urlHandler: URLHandler?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    self.configureAppLaunch(from: scene)
  }
}

extension SceneDelegate {
  private func configureAppLaunch(from windowScene: UIWindowScene) {
    let appComponent = AppComponent()
    let rootBuilder = appComponent.rootBuilder
    (self.launchRouter, self.urlHandler) = rootBuilder.build()

    self.configureWindowWithLaunch(from: windowScene)
  }

  private func configureWindowWithLaunch(from windowScene: UIWindowScene) {
    let window = UIWindow(windowScene: windowScene)
    self.window = window
    self.launchRouter?.launch(from: window)
  }
}
