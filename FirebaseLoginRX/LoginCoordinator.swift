//
//  LoginCoordinator.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

final class LoginCoordinator {
  
  // MARK: - DEPENDENCIES
  
  fileprivate let navigationController: UINavigationController
  
  // MARK: - INITIALIZER
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
}

extension LoginCoordinator: Coordinator {
  
  func start() {
    let loginViewController = LoginViewController()
    navigationController.viewControllers = [loginViewController]
  }
  
}
