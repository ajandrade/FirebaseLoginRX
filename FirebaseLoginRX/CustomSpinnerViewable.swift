//
//  CustomSpinnerViewable.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import NVActivityIndicatorView

protocol CustomSpinnerViewable: NVActivityIndicatorViewable { }

extension CustomSpinnerViewable where Self: UIViewController {
  
  func startAnimatingLoginSpinner() {
    startAnimating(
      CGSize(width: 40, height: 40),
      message: "Logging in...\nPlease wait",
      messageFont: UIFont(name: "AvenirNext-Bold", size: 14),
      type: .ballScaleRippleMultiple,
      color: UIColor.white
    )
  }
  
  func stopAnimatingCustomSpinner() {
    stopAnimating()
  }
  
}
