//
//  File.swift
//  LoginDemo-MVVM
//
//  Created by Aklesh on 10/06/22.
//

import Foundation
import UIKit

struct StoryBoards {
    static var main = "Main"
}

struct RedirectionHelper {

    static func redirectToWelcomePage() {
        DispatchQueue.main.async {
            let welcomeVC = UIStoryboard(name: StoryBoards.main, bundle: nil).instantiateViewController(withIdentifier: WelcomeViewController.nameOfClass)
            UIApplication.shared.keyWindow?.rootViewController = welcomeVC
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }
}
