//
//  GoogleSignIn+Rx.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import GoogleSignIn
import RxSwift
import RxCocoa

class RxGoogleSignInDelegateProxy: DelegateProxy, GIDSignInDelegate, DelegateProxyType {
  
  internal lazy var signInSubject = PublishSubject<GIDGoogleUser>()
  
  class func setCurrentDelegate(_ delegate: AnyObject?, toObject object:
    AnyObject) {
    let googleSignIn = object as! GIDSignIn
    googleSignIn.delegate = delegate as? GIDSignInDelegate
  }
  
  class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
    let googleSignIn = object as! GIDSignIn
    return googleSignIn.delegate
  }
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    self._forwardToDelegate?.sign(signIn, didSignInFor: user, withError: error)
    if let user = user {
      signInSubject.onNext(user)
    } else if let error = error {
      signInSubject.onError(error)
    }
  }
  
  deinit {
    signInSubject.on(.completed)
  }
  
}

extension Reactive where Base: GIDSignIn {
  
  var delegate: DelegateProxy {
    return RxGoogleSignInDelegateProxy.proxyForObject(base)
  }
  
  var signIn: Observable<GIDGoogleUser> {
    return (delegate as! RxGoogleSignInDelegateProxy).signInSubject.asObservable()
  }
  
}
