//
//  FacebookTokenFetcher.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import FacebookCore
import FacebookLogin
import RxSwift

struct FacebookTokenFetcher {
  
  var accessToken: Observable<FacebookAuth> {
    return Observable.create { observer in
      let loginManager = LoginManager()
      loginManager.logIn([.publicProfile, .email]) { loginResult in
        switch loginResult {
        case .failed(let error):
          observer.onError(error)
        case .cancelled:
          observer.onCompleted()
        case .success(_, _, let accessToken):
          let auth = FacebookAuth(token: accessToken.authenticationToken)
          observer.onNext(auth)
          observer.onCompleted()
        }
      }
      return Disposables.create()
    }
  }
  
}
