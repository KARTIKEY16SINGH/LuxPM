//
//  GUIManager.swift
//  Alphametrica
//
//  Created by Iron Man on 18/04/21.
//

import UIKit

struct GUIManager {
    static func getHightlightedString(text: String, highlightedText hText: String, fontFamilyName ffName: String, size: CGFloat) -> NSMutableAttributedString {
        let attributedStr = NSMutableAttributedString(string: text, attributes: [.font : UIFont(name: ffName + "-Regular", size: size) ?? Helper.defaultFont])
        let range = attributedStr.mutableString.range(of: hText)
        attributedStr.addAttribute(.font, value: UIFont(name: ffName+"-Bold", size: size) ?? Helper.defaultFont, range: range)
        return attributedStr
    }
    
    static func showAlert(title: String? = nil, message: String, presenter: UIViewController) {
        let alert = UIAlertController.init(title: title ?? "Alert!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    static func getLonginViewController() -> UIViewController {
        let vc = UIStoryboard(name: "LoginStoryboard", bundle: Bundle(for: LoginViewController.self)).instantiateInitialViewController()
        return vc ?? LoginViewController()
    }
    
    static func getSignupViewController() -> UIViewController {
        let vc = UIStoryboard(name: "SignupStoryboard", bundle: Bundle(for: SignupViewController.self)).instantiateInitialViewController()
        return vc ?? SignupViewController()
    }
}

extension UIViewController {
    func setupForKeyboardUse() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyBoardDidHide(notification: NSNotification) {}
}
