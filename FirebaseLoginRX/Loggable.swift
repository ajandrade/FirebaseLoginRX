//
//  Loggable.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Firebase
import RxSwift

protocol Loggable {
  
  func signIn(withCredential credential: AuthCredential) -> Observable<User>
  func signIn(withEmail emailAuth: EmailAuth) -> Observable<User>
  
}
