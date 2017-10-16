//
//  LoginFinishedViewModel.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import RxSwift
import Action

protocol LoginFinishedViewModelType {
  var onLogout: CocoaAction { get }
}

struct LoginFinishedViewModel: LoginFinishedViewModelType {
  
  // MARK: - DEPENDENCIES
  
  typealias LoginFinishedNetworkDependencies = HasUserService
  
  private let networkDependencies: LoginFinishedNetworkDependencies
  
  // MARK: - OUTPUT PROPERTIES
  
  private(set) var onLogout: CocoaAction

  // MARK: - INITIALIZER
  
  init(networkDependencies: NetworkDependencies, navigation: LoginFinishedNavigation) {
    self.networkDependencies = networkDependencies
    onLogout = CocoaAction {
      return networkDependencies.userService
        .logout()
        .flatMap { navigation.performLogout.execute() }
    }
  }
  
}
