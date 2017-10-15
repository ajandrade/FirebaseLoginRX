//
//  Roundable.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol Roundable { }

extension Roundable where Self: UIView {
  
  func rounded() {
    self.layer.cornerRadius = self.frame.size.width/2
    self.clipsToBounds = true
  }
  
  func round(withRadius radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
  }
  
}
