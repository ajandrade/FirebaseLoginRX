//
//  Bordable.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol Bordable { }

extension Bordable where Self: UIView {
  
  func bordered(withColor color: UIColor, width: CGFloat = 1.0) {
    self.layer.borderColor = color.cgColor
    self.layer.borderWidth = width
  }
  
}
