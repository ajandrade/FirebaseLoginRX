//
//  User.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Firebase

extension User {
  
  func toDictionary() -> [String: String] {
    var result: [String: String] = [:]
    
    if let name = self.displayName {
      result["name"] = name
    }
    if let email = self.email {
      result["email"] = email
    }
    if let photoUrl = self.photoURL {
      result["photoUrl"] = String(describing: photoUrl)
    }
    
    return result
  }
  
}
