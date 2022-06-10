//
//  Extension.swift
//  LoginDemo-MVVM
//
//  Created by Aklesh on 10/06/22.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isPhoneNumber: Bool {
            do {
                let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
                let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
                if let res = matches.first {
                    return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
                } else {
                    return false
                }
            } catch {
                return false
            }
        }
}

extension UIButton {
    func configure(_ cornerRadius: CGFloat, borderColor: UIColor?) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor?.cgColor
        self.layer.cornerRadius = cornerRadius
    }
}

extension UIViewController {
    func showAlert(_ title: String, message: String, actions: [String], completion: @escaping ((String) -> Void)) {
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for title in actions {
            controller.addAction(UIAlertAction.init(title: title, style: .default, handler: { _ in
                completion(title)
            }))
        }
        self.present(controller, animated: true, completion: nil)
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}

public extension NSObject {
    class var nameOfClass: String {
        let componentsList = NSStringFromClass(self).split(separator: ".").map(String.init)
        return componentsList.last!
    }
}
