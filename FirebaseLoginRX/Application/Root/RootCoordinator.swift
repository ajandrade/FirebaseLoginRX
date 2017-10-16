//
//  RootCoordinator.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

final class RootCoordinator {
  
  // MARK: - DEPENDENCIES
  
  private let window: UIWindow
  fileprivate let navigator: NavigatorRepresentable
  
  // MARK: - PROPERTIES
  
  fileprivate let networkServices = NetworkDependencies()
  
  // MARK: - INITIALIZER
  
  init(window: UIWindow, navigator: NavigatorRepresentable) {
    self.window = window
    self.navigator = navigator
    self.window.rootViewController = navigator.root()
    self.window.makeKeyAndVisible()
  }
  
}

extension RootCoordinator: Coordinator {
  
  func start() {
    let loginCoordinator = LoginCoordinator(navigator: navigator, networkServices: networkServices)
    loginCoordinator.start()
  }
  
}
