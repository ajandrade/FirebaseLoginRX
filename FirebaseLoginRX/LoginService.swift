//
//  LoginService.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Firebase
import RxSwift

struct LoginService: FirebaseCRUD {
  
  // MARK: - DEPENDENCIES
  
  private let facebookHelper: FacebookTokenFetcher
  private let googleHelper: GoogleTokenFetcher
  private let twitterHelper: TwitterTokenFetcher
  
  // MARK: - PROPERTIES
  
  enum SocialView {
    case facebook
    case google
    case twitter
  }
  
  // MARK: - INITIALIZER
  
  init(facebookHelper: FacebookTokenFetcher, googleHelper: GoogleTokenFetcher, twitterHelper: TwitterTokenFetcher) {
    self.facebookHelper = facebookHelper
    self.googleHelper = googleHelper
    self.twitterHelper = twitterHelper
  }
  
  // MARK: - TOKENS
  
  private var facebookToken: Observable<FacebookAuth> {
    return facebookHelper.accessToken
  }
  
  private var googleToken: Observable<GoogleAuth> {
    return googleHelper.signIn
  }
  
  private var twitterToken: Observable<TwitterAuth> {
    return twitterHelper.token
  }
  
  
  // MARK: - CREDENTIALS
  
  private func facebookCredential(_ auth: FacebookAuth) -> AuthCredential {
    return FacebookAuthProvider.credential(withAccessToken: auth.token)
  }
  
  private func googleCredential(_ auth: GoogleAuth) -> AuthCredential {
    return GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
  }
  
  private func twitterCredential(_ auth: TwitterAuth) -> AuthCredential {
    return TwitterAuthProvider.credential(withToken: auth.token, secret: auth.tokenSecret)
  }
  
  // MARK: - SIGN IN
  
  
  func showSocialView(for social: SocialView) -> Observable<AuthCredential> {
    switch social {
    case .facebook:
      return facebookToken
        .map(facebookCredential)
    case .google:
      return googleToken
        .map(googleCredential)
    case .twitter:
      return twitterToken
        .map(twitterCredential)
    }
  }
  
}

extension LoginService: Loggable {
  
  func signIn(withCredential credential: AuthCredential) -> Observable<User> {
    return Observable.create { observer in
      Auth.auth().signIn(with: credential) { (user, error) in
        guard let user = user else {
          observer.onError(error!)
          return
        }
        observer.onNext(user)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func signIn(withEmail emailAuth: EmailAuth) -> Observable<User> {
    return Observable.create { observer in
      Auth.auth().signIn(withEmail: emailAuth.email, password: emailAuth.password) { (user, error) in
        guard let user = user else {
          observer.onError(error!)
          return
        }
        observer.onNext(user)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func createAccount(with emailAuth: EmailAuth) -> Observable<User> {
    return Observable.create { observer in
      Auth.auth().createUser(withEmail: emailAuth.email, password: emailAuth.password) { (user, error) in
        guard let user = user else {
          observer.onError(error!)
          return
        }
        observer.onNext(user)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
}
