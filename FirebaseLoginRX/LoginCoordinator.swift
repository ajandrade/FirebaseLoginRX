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
  fileprivate let networkServices: NetworkDependencies
  
  // MARK: - INITIALIZER
  
  init(navigationController: UINavigationController, networkServices: NetworkDependencies) {
    self.navigationController = navigationController
    self.networkServices = networkServices
  }
  
}

extension LoginCoordinator: Coordinator {
  
  func start() {
    let loginViewController = LoginViewController()
    let loginViewModel = LoginViewModel(networkDependencies: networkServices)
    loginViewController.viewModel = loginViewModel
    navigationController.viewControllers = [loginViewController]
  }
  
}
