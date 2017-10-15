//
//  Registrable.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Firebase
import RxSwift

protocol Registrable {
  
  func updateDB(with user: User) -> Observable<Void>
  
}
