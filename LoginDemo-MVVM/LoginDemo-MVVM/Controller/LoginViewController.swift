//
//  ViewController.swift
//  LoginDemo-MVVM
//
//  Created by Aklesh on 10/06/22.
//

import UIKit

class LoginViewController: UIViewController {
    var viewModel = LoginViewModel()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginWithMobileButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    fileprivate func configureView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        mobileTextField.delegate = self

        loginButton.configure(5.0, borderColor: .clear)
        loginWithMobileButton.configure(5.0, borderColor: .clear)
    }


    @IBAction func loginAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateInput(emailTextField.text, password: passwordTextField.text) { [weak self] (success, message) in
            if success {
                self?.performAPICall()
            } else {
                self?.showAlert("Error!", message: message!, actions: ["Ok"]) { (actionTitle) in
                    print(actionTitle)
                }
            }
        }
    }
    
    @IBAction func loginWithMobileAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateMobileInput(mobileTextField.text) { [weak self] (success, message) in
            if success {
                self?.performAPICall()
            } else {
                self?.showAlert("Error!", message: message!, actions: ["Ok"]) { (actionTitle) in
                    print(actionTitle)
                }
            }
        }
    }


    private func performAPICall() {
        let request = LoginRequestModel(username: emailTextField.text!, password: passwordTextField.text!)
        viewModel.login(request) { (responseModel) in
            if responseModel.success {
                RedirectionHelper.redirectToWelcomePage()
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            self.loginAction(loginButton)
        }
        else if textField == mobileTextField {
           self.loginWithMobileAction(loginWithMobileButton)
       }
        return true
    }
}

