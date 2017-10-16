//
//  Alertable.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol Alertable { }

extension Alertable where Self: UIViewController {

  func showErrorAlert(with message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
  
}
