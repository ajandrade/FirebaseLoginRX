//
//  GoogleTokenFetcher.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import RxSwift
import RxCocoa
import GoogleSignIn
import Action

struct GoogleTokenFetcher {
  
  var signIn: Observable<GoogleAuth> {
    GIDSignIn.sharedInstance().signIn()
    return GIDSignIn.sharedInstance().rx
      .signIn
      .map(GoogleAuth.init)
  }
  
}
