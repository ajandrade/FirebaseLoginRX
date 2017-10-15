//
//  UserService.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Firebase
import RxSwift

struct UserService {
  
  // MARK: - OUTPUT PROPERTIES
  
  var isLoggedIn: Bool {
    return Auth.auth().currentUser != nil
  }
  
  // MARK: - FUNCTIONS
  
  func logout() -> Observable<Void> {
    return Observable.create { observer in
      let firebaseAuth = Auth.auth()
      do {
        try firebaseAuth.signOut()
        observer.onNext()
        observer.onCompleted()
      } catch let signOutError as NSError {
        observer.onError(signOutError)
      }
      return Disposables.create()
    }
  }
  
  
}
