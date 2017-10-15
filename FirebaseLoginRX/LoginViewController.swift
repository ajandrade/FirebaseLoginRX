//
//  LoginViewController.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import GoogleSignIn

extension LoginViewController: GIDSignInUIDelegate { }
extension LoginViewController: CustomSpinnerViewable { }

class LoginViewController: UIViewController {
  
  // MARK: - DEPENDENCIES
  
  var viewModel: LoginViewModelType!
  
  // MARK: - PROPERTIES
  
  private let bag = DisposeBag()
  
  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var emailTextField: UITextField! {
    didSet { emailTextField.round(withRadius: 5.0) }
  }
  @IBOutlet private weak var passTextField: UITextField! {
    didSet { passTextField.round(withRadius: 5.0) }
  }
  @IBOutlet private weak var loginButton: UIButton!
  @IBOutlet private weak var facebookButton: UIButton!
  @IBOutlet private weak var googleButton: UIButton! {
    didSet { GIDSignIn.sharedInstance().uiDelegate = self }
  }
  @IBOutlet private weak var twitterButton: UIButton!
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindKeyboards()
    bindActions()
    bindViewModel()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopAnimatingCustomSpinner()
  }
  
  // MARK: - BINDINGS
  
  private func bindActions() {
    
    facebookButton.rx
      .tap
      .subscribe(onNext: { [weak self] _ in self?.viewModel.onFacebook.execute() })
      .disposed(by: bag)
    
    googleButton.rx
      .tap
      .subscribe(onNext: { [weak self] _ in self?.viewModel.onGoogle.execute() })
      .disposed(by: bag)
    
    twitterButton.rx
      .tap
      .subscribe(onNext: { [weak self] _ in self?.viewModel.onTwitter.execute() })
      .disposed(by: bag)
    
    let loginAction = viewModel.onLogin
    
    let textInputs = Observable.combineLatest(emailTextField.rx.text.orEmpty, passTextField.rx.text.orEmpty) { email, pass in
      return (email, pass)
    }
    
    loginButton.rx
      .tap
      .withLatestFrom(textInputs)
      .bind(to: loginAction.inputs)
      .disposed(by: bag)
    
    passTextField.rx
      .controlEvent(.editingDidEndOnExit)
      .withLatestFrom(textInputs)
      .bind(to: loginAction.inputs)
      .disposed(by: bag)
  }
  
  private func bindKeyboards() {
    
    let tapGesture = UITapGestureRecognizer()
    tapGesture.rx
      .event
      .subscribe(onNext: { [weak self] _ in self?.view.endEditing(true) })
      .disposed(by: bag)
    self.view.addGestureRecognizer(tapGesture)
    
    emailTextField.rx
      .controlEvent(.editingDidEndOnExit)
      .subscribe(onNext: { [weak self] _ in
        self?.emailTextField.resignFirstResponder()
        self?.passTextField.becomeFirstResponder()
      })
      .disposed(by: bag)
    
    loginButton.rx
      .tap
      .subscribe(onNext: { [weak self] _ in self?.passTextField.resignFirstResponder() })
      .disposed(by: bag)
    
    passTextField.rx
      .controlEvent(.editingDidEndOnExit)
      .subscribe(onNext: { [weak self] _ in self?.passTextField.resignFirstResponder() })
      .disposed(by: bag)
  }
  
  private func bindViewModel() {
    emailTextField.rx
      .text
      .orEmpty
      .bind(to: viewModel.emailText)
      .disposed(by: bag)
    
    passTextField.rx
      .text
      .orEmpty
      .bind(to: viewModel.passText)
      .disposed(by: bag)
    
    viewModel.loginEnabled
      .subscribe(onNext: { [weak self] isEnabled in
        self?.loginButton.alpha = isEnabled ? 1 : 0.3
        self?.loginButton.isEnabled = isEnabled
      })
      .disposed(by: bag)
    
    viewModel.emailValid
      .subscribe(onNext: { [weak self] isValid in
        if let text = self?.emailTextField.text, text.isEmpty {
          self?.emailTextField.bordered(withColor: UIColor.clear)
        } else {
          self?.emailTextField.bordered(withColor: isValid ? UIColor.clear : UIColor.red)
        }
      })
      .disposed(by: bag)
    
    viewModel.passwordValid
      .subscribe(onNext: { [weak self] isValid in
        if let text = self?.passTextField.text, text.isEmpty {
          self?.passTextField.bordered(withColor: UIColor.clear)
        } else {
          self?.passTextField.bordered(withColor: isValid ? UIColor.clear : UIColor.red)
        }
      })
      .disposed(by: bag)
    
    viewModel.isLoggingIn
      .subscribe(onNext: { [weak self] _ in self?.startAnimatingLoginSpinner() })
      .disposed(by: bag)
    
    viewModel.didFinishLoginWithError
      .subscribe(onNext: { [weak self] errorDescription in
        self?.stopAnimatingCustomSpinner()
        let alert = UIAlertController(title: "Error", message: errorDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self?.present(alert, animated: true, completion: nil)
      })
      .disposed(by: bag)

  }
  
}
