//
//  LoginViewModel.swift
//  LoginDemo-MVVM
//
//  Created by Aklesh on 10/06/22.
//

import Foundation

struct LoginViewModel {
    let passwordLengthRange = (6, 14) // (minimum length, maximum length)
    let usernameEmptyMessage = "Please Enter Email"
    let passwordEmptyMessage = "Please Enter Password"
    let usernameErrorMessage = "Entered email is invalid"
    let passwordErrorMessage = "Password length must be in range 6-10 characters."
    let mobileEmptyMessage = "Please Enter Mobile"
    let mobileErrorMessage = "Entered mobile is invalid"

    func validateInput(_ username: String?, password: String?, completion: (Bool, String?) -> Void) {
        if let username = username {
            if username.isEmpty {
                completion(false, usernameEmptyMessage)
                return
            } else if !username.isValidEmail() {
                completion(false, usernameErrorMessage)
                return
            }
        } else {
            completion(false, usernameEmptyMessage)
            return
        }
        if let password = password {
            if password.isEmpty {
                completion(false, passwordEmptyMessage)
                return
            } else if !validateTextLength(password, range: passwordLengthRange) {
                completion(false, passwordErrorMessage)
                return
            }
        } else {
            completion(false, passwordEmptyMessage)
            return
        }
        // Validated successfully.
        completion(true, nil)
    }
    
    func validateMobileInput(_ mobileNNumber: String?, completion: (Bool, String?) -> Void) {
        if let mobile = mobileNNumber {
            if mobile.isEmpty {
                completion(false, mobileEmptyMessage)
                return
            } else if !mobile.isPhoneNumber {
                completion(false, mobileErrorMessage)
                return
            }
        } else {
            completion(false, mobileEmptyMessage)
            return
        }
        // Validated successfully.
        completion(true, nil)
    }

    private func validateTextLength(_ text: String, range: (Int, Int)) -> Bool {
        return (text.count >= range.0) && (text.count <= range.1)
    }

    func login(_ requestModel: LoginRequestModel, completion: @escaping (LoginResponseModel) -> Void) {
        let params = requestModel.getParams()
        print("Input:\(params)")
        var responseModel = LoginResponseModel()
        responseModel.success = true
        responseModel.successMessage = "User logged in successfully"
        completion(responseModel)
        
        // Make api call here.

    }
}

struct LoginRequestModel {
    var username: String
    var password: String
    var mobile: String


    init(username: String, password: String, mobile:String = "") {
        self.username = username
        self.password = password
        self.mobile = mobile

    }

    func getParams() -> [String: Any] {
        return ["username": username, "password": password, "mobile": mobile]
    }
}

struct LoginResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data: Any?
}

