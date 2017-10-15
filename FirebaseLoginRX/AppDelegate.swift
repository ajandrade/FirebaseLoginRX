//
//  AppDelegate.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Firebase
    FirebaseApp.configure()
    // Facebook
    SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

    window = UIWindow(frame: UIScreen.main.bounds)
    let rootCoordinator = RootCoordinator(window: window!)
    rootCoordinator.start()
    
    return true
  }
  
  func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
    -> Bool {
      let facebook = SDKApplicationDelegate.shared.application(application, open: url, options: options)
      
      return facebook
  }


}

