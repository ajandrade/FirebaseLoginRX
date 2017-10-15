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
  var emailText: PublishSubject<String> { get }
  var passText: PublishSubject<String> { get }
  
  // Output
  var loginEnabled: Observable<Bool> { get }
  var passwordValid: Observable<Bool> { get }
  var emailValid: Observable<Bool> { get }
  var isLoggingIn: Observable<Bool> { get }
  var didFinishLoginWithError: Observable<String> { get }
  
  var onLogin: Action<(String, String),Void> { get }
  var onFacebook: Action<Void,AuthCredential> { get }
  var onGoogle: Action<Void,AuthCredential> { get }
  var onTwitter: Action<Void,AuthCredential> { get }
}

struct LoginViewModel: LoginViewModelType {
  
  // MARK: - DEPENDENCIES
  
  typealias LoginNetworkDependencies = HasLoginService
  
  private let networkDependencies: LoginNetworkDependencies
  
  // MARK: - INPUT PROPERTIES
  
  let emailText = PublishSubject<String>()
  let passText = PublishSubject<String>()
  
  // MARK: - OUTPUT PROPERTIES
  
  private(set) var loginEnabled: Observable<Bool>
  private(set) var passwordValid: Observable<Bool>
  private(set) var emailValid: Observable<Bool>
  private(set) var isLoggingIn: Observable<Bool>
  private(set) var didFinishLoginWithError: Observable<String>
  
  private(set) var onLogin: Action<(String, String),Void>
  private(set) var onFacebook: Action<Void,AuthCredential>
  private(set) var onGoogle: Action<Void,AuthCredential>
  private(set) var onTwitter: Action<Void,AuthCredential>

  // MARK: - INTERNAL PROPERTIES
  
  private let signIn: Action<AuthCredential, Void>
  private let bag = DisposeBag()

  // MARK: - INITIALIZER

  init(networkDependencies: NetworkDependencies) {
    self.networkDependencies = networkDependencies
    
    emailValid = emailText
      .map { EmailHelper.isValidEmail($0) }
    
    passwordValid = passText
      .map { $0.characters.count >= 6 }
    
    loginEnabled = Observable
      .combineLatest(emailValid, passwordValid) { email, pass in
        return email && pass
      }.shareReplay(1)
    
    onLogin = Action(enabledIf: loginEnabled) { credentials in
      let emailAuth = EmailAuth(email: credentials.0, password: credentials.1)
      return networkDependencies.loginService
        .signIn(withEmail: emailAuth)
        .catchError { error in
          let errCode = AuthErrorCode(rawValue: error._code)
          if errCode == .userNotFound {
            return networkDependencies.loginService.createAccount(with: emailAuth)
          }
          return Observable.error(error)
        }
        .flatMap { user -> Observable<Void> in
          print(user)
          // TODO: - Update on DB
          return Observable.empty() // remove this
        }
        .flatMap { _ -> Observable<Void> in
          // TODO: - Do navigation to next screen
          return Observable.empty()
      }
    }

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
    
    signIn = Action { credential in
      return networkDependencies.loginService.signIn(withCredential: credential)
        .flatMap { user -> Observable<Void> in
          print(user)
          // TODO: - Update on DB
          return Observable.empty() // remove this
        }
        .flatMap { _ -> Observable<Void> in
          // TODO: - Do navigation to next screen
          return Observable.empty()
      }
    }
    
    let didFinishGettingAuth = Observable
      .merge(onGoogle.elements, onFacebook.elements, onTwitter.elements)
      .take(1)
    
    didFinishGettingAuth
      .bind(to: signIn.inputs)
      .disposed(by: bag)

    let didFinishShowingSocialView = didFinishGettingAuth.map { _ in return true }
    
    isLoggingIn = Observable
      .merge([didFinishShowingSocialView, onLogin.executing])
      .filter { $0 }
    
    didFinishLoginWithError = Observable
      .merge([onLogin.errors, onFacebook.errors, onGoogle.errors, onTwitter.errors])
      .map { error in
        if case .underlyingError(let err) = error {
          return err.localizedDescription
        }
        return "Unknown Error"
    }
  }
  
}
