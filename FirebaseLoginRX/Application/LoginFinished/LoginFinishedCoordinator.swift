//
//  LoginFinishedCoordinator.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit
import Action
import RxSwift

protocol LoginFinishedNavigation {
  var performLogout: CocoaAction { get }
}

final class LoginFinishedCoordinator {
  
  // MARK: - PROPERTIES
  
  fileprivate let navigator: NavigatorRepresentable
  fileprivate let networkServices: NetworkDependencies
  
  // MARK: - NAVIGATION
  
  fileprivate struct Navigation: LoginFinishedNavigation {
    let performLogout: CocoaAction
  }
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, networkServices: NetworkDependencies) {
    self.navigator = navigator
    self.networkServices = networkServices
  }
  
}

extension LoginFinishedCoordinator: Coordinator {
  
  func start() {
    let loginFinishedViewController = LoginFinishedViewController()
    let navigation = buildNavigationActions()
    let loginFinishedViewModel = LoginFinishedViewModel(networkDependencies: networkServices, navigation: navigation)
    loginFinishedViewController.viewModel = loginFinishedViewModel
    navigator.transition(to: loginFinishedViewController, type: .push)
  }
  
  private func buildNavigationActions() -> Navigation {
    let performLogout = CocoaAction {
      self.navigator.dismiss()
      return Observable.empty()
    }
    
    return Navigation(performLogout: performLogout)
  }
  
}
