//
//  LoginViewModel.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import RxSwift
import Action
import Firebase

protocol LoginViewModelType {
  // Input

  // Output
  var onFacebook: Action<Void,AuthCredential> { get }
  var onGoogle: Action<Void,AuthCredential> { get }
  var onTwitter: Action<Void,AuthCredential> { get }

}

struct LoginViewModel: LoginViewModelType {
  
  // MARK: - DEPENDENCIES
  
  typealias LoginNetworkDependencies = HasLoginService
  
  private let networkDependencies: LoginNetworkDependencies
  
  // MARK: - OUTPUT PROPERTIES
  
  private(set) var onFacebook: Action<Void,AuthCredential>
  private(set) var onGoogle: Action<Void,AuthCredential>
  private(set) var onTwitter: Action<Void,AuthCredential>

  // MARK: - INITIALIZER

  init(networkDependencies: NetworkDependencies) {
    self.networkDependencies = networkDependencies
    
    onFacebook = Action {
      return networkDependencies.loginService
        .showSocialView(for: .facebook)
    }
    
    onGoogle = Action {
      return networkDependencies.loginService
        .showSocialView(for: .google)
    }
    
    onTwitter = Action {
      return networkDependencies.loginService
        .showSocialView(for: .twitter)
    }
    
  }
  
}
