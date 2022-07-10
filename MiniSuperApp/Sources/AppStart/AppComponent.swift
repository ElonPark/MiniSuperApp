//
//  AppComponent.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import Foundation

import NeedleFoundation

final class AppComponent: BootstrapComponent {
  var rootBuilder: RootBuildable {
    RootBuilder {
      RootComponent(parent: self)
    }
  }
}
