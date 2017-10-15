//
//  LoginCoordinator.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit
import RxSwift
import Action

protocol LoginNavigation {
  var performLogin: CocoaAction { get }
}

final class LoginCoordinator {
  
  // MARK: - DEPENDENCIES
  
  fileprivate let navigator: NavigatorRepresentable
  fileprivate let networkServices: NetworkDependencies
  
  // MARK: - NAVIGATION
  
  fileprivate struct Navigation: LoginNavigation {
    let performLogin: CocoaAction
  }
  
  // MARK: - INITIALIZER

  init(navigator: NavigatorRepresentable, networkServices: NetworkDependencies) {
    self.navigator = navigator
    self.networkServices = networkServices
  }
  
}

extension LoginCoordinator: Coordinator {
  
  func start() {
    let loginViewController = LoginViewController()
    let navigation = buildNavigationActions()
    let loginViewModel = LoginViewModel(networkDependencies: networkServices, navigation: navigation)
    loginViewController.viewModel = loginViewModel
    navigator.transition(to: loginViewController, type: .root)
  }
  
  private func buildNavigationActions() -> Navigation {
    let performLogin = CocoaAction {
      let loginFinishedCoordinator = LoginFinishedCoordinator(navigator: self.navigator, networkServices: self.networkServices)
      loginFinishedCoordinator.start()
      return Observable.empty()
    }
    
    return Navigation(performLogin: performLogin)
  }

  
}
