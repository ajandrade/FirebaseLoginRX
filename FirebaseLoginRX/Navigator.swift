//
//  Navigator.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol NavigatorRepresentable {
  func root() -> UINavigationController
  func transition(to viewController: UIViewController, type: NavigationTransitionType)
  func dismiss()
}

struct Navigator: NavigatorRepresentable {
  
  private var rootNavigationController: UINavigationController = {
    let navController = UINavigationController()
    navController.setNavigationBarHidden(true, animated: false)
    return navController
  }()
  
  func root() -> UINavigationController {
    return rootNavigationController
  }
  
  func transition(to viewController: UIViewController, type: NavigationTransitionType) {
    switch type {
    case .root:
      rootNavigationController.viewControllers = [viewController]
    case .modal:
      rootNavigationController.present(viewController, animated: true, completion: nil)
    case .push:
      rootNavigationController.pushViewController(viewController, animated: true)
    }
  }
  
  func dismiss() {
    if rootNavigationController.presentingViewController != nil {
      rootNavigationController.dismiss(animated: true, completion: nil)
    } else {
      rootNavigationController.popViewController(animated: true)
    }
  }
  
}
