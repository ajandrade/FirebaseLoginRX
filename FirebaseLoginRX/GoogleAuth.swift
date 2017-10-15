//
//  GoogleAuth.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import GoogleSignIn

struct GoogleAuth {
  
  let idToken: String
  let accessToken: String
  
  init(user: GIDGoogleUser) {
    idToken = user.authentication.idToken
    accessToken = user.authentication.accessToken
  }
  
}
