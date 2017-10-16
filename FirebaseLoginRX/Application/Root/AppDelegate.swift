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
import GoogleSignIn
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Firebase
    FirebaseApp.configure()
    // Facebook
    SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    // Google
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    // Twitter
    Twitter.sharedInstance().start(withConsumerKey:"7RFDU0nx0aNFJN0IAGNZVv8j3", consumerSecret:"2LfZCAl8lEgIk0xihgnf9PJuDuHY8OKOHTWP9V938deA8TOf6o")

    window = UIWindow(frame: UIScreen.main.bounds)

    let navigator = Navigator()

    let rootCoordinator = RootCoordinator(window: window!, navigator: navigator)
    rootCoordinator.start()
    
    return true
  }
  
  func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
    -> Bool {
      let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
      let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
      
      let facebook = SDKApplicationDelegate.shared.application(application, open: url, options: options)
      
      let google = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
      
      let twitter = Twitter.sharedInstance().application(application, open: url, options: options)
      
      return facebook || google || twitter
  }

}

