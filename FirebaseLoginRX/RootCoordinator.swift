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
  
  // MARK: - PROPERTIES
  
  fileprivate let navigationController: UINavigationController = {
    let navController = UINavigationController()
    navController.setNavigationBarHidden(true, animated: false)
    return navController
  }()
  
  fileprivate let networkServices = NetworkDependencies()
  
  // MARK: - INITIALIZER
  
  init(window: UIWindow) {
    self.window = window
    self.window.rootViewController = navigationController
    self.window.makeKeyAndVisible()
  }
  
}

extension RootCoordinator: Coordinator {
  
  func start() {
    let loginCoordinator = LoginCoordinator(navigationController: navigationController, networkServices: networkServices)
    loginCoordinator.start()
  }
  
}
