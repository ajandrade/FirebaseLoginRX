//
//  TwitterTokenFetcher.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import RxSwift
import TwitterKit

struct TwitterTokenFetcher {
  
  var token: Observable<TwitterAuth> {
    return Observable.create { observer in
      Twitter.sharedInstance().logIn(completion: { (session, error) in
        guard let session = session else {
          observer.onError(error!)
          return
        }
        let auth = TwitterAuth(token: session.authToken, tokenSecret: session.authTokenSecret)
        
        observer.onNext(auth)
        observer.onCompleted()
      })
      return Disposables.create()
    }
  }
  
}
