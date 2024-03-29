//
//  SplashSampleAppComponent.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import Foundation

import NeedleFoundation

import BootstrapData
import BootstrapDomain
import Network
import NetworkInterface
import Splash
import SplashInterface

final class AppComponent: BootstrapComponent {
  var rootBuilder: RootBuildable {
    RootBuilder {
      RootComponent(parent: self)
    }
  }

  var splashBuilder: SplashBuildable {
    SplashBuilder {
      SplashComponent(parent: self)
    }
  }

  var bootstrapRepository: BootstrapRepository {
    BootstrapRepositoryImpl(network: network)
  }

  var network: Networking {
    Network(
      plugins: [
        NetworkLoggerPlugin(),
      ]
    )
  }
}
