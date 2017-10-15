//
//  NetworkDependencies.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

struct NetworkDependencies: HasLoginService, HasUserService {
  let loginService: LoginService
  let userService: UserService
  
  init() {
    let facebookHelper = FacebookTokenFetcher()
    let googleHelper = GoogleTokenFetcher()
    let twitterHelper = TwitterTokenFetcher()
    loginService = LoginService(facebookHelper: facebookHelper, googleHelper: googleHelper, twitterHelper: twitterHelper)
    userService = UserService()
  }
}
