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
  
  fileprivate let navigator: NavigatorRepresentable
  fileprivate let networkServices: NetworkDependencies
  
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, networkServices: NetworkDependencies) {
    self.navigator = navigator
    self.networkServices = networkServices
  }
  
}

extension LoginFinishedCoordinator: Coordinator {
  
  func start() {
    let loginFinishedViewController = LoginFinishedViewController()
    let loginFinishedViewModel = LoginFinishedViewModel()
    loginFinishedViewController.viewModel = loginFinishedViewModel
    navigator.transition(to: loginFinishedViewController, type: .push)
  }
  
}
