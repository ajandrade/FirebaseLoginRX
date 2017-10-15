//
//  NetworkServiceProtocols.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol HasLoginService {
  var loginService: LoginService { get }
}

protocol HasUserService {
  var userService: UserService { get }
}
