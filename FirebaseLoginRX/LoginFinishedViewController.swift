//
//  LoginFinishedViewController.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

class LoginFinishedViewController: UIViewController {
  
  // MARK: - DEPENDENCIES
  
  var viewModel: LoginFinishedViewModelType!

  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var logoutButton: UIButton!

  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    logoutButton.rx.action = viewModel.onLogout
  }
  
}
