//
//  AppComponent.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import Foundation

import NeedleFoundation

import LoggedOut
import LoggedOutInterface
import Network
import NetworkInterface

final class AppComponent: BootstrapComponent {
  var rootBuilder: RootBuildable {
    RootBuilder {
      RootComponent(parent: self)
    }
  }

  var loggedOutBuilder: LoggedOutBuildable {
    LoggedOutBuilder {
      LoggedOutComponent(parent: self)
    }
  }

  var network: Networking {
    Network(
      plugins: [
        NetworkLoggerPlugin(),
      ]
    )
  }
}
