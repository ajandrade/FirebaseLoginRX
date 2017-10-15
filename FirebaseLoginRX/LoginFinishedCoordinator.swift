//
//  LoginFinishedCoordinator.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

final class LoginFinishedCoordinator {
  
  // MARK: - PROPERTIES
  
  fileprivate let navigationController: UINavigationController
  fileprivate let networkServices: NetworkDependencies
  
  
  // MARK: - INITIALIZER
  
  init(navigationController: UINavigationController, networkServices: NetworkDependencies) {
    self.navigationController = navigationController
    self.networkServices = networkServices
  }
  
}

extension LoginFinishedCoordinator: Coordinator {
  
  func start() {
    let loginFinishedViewController = LoginFinishedViewController()
    let loginFinishedViewModel = LoginFinishedViewModel()
    loginFinishedViewController.viewModel = loginFinishedViewModel
    navigationController.viewControllers = [loginFinishedViewController]
  }
  
}
