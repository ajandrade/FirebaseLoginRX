//
//  LoginViewModel.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

protocol LoginViewModelType {
  
}

struct LoginViewModel: LoginViewModelType {
  
  // MARK: - DEPENDENCIES
  
  typealias LoginNetworkDependencies = HasLoginService
  
  private let networkDependencies: LoginNetworkDependencies

  // MARK: - INITIALIZER

  init(networkDependencies: NetworkDependencies) {
    self.networkDependencies = networkDependencies
  }
  
}
