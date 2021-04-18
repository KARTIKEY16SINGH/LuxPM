//
//  Constants.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

struct Helper {
    enum ScreenType {
        case main
        case signUp
        case login
    }
    
    static let signUpText = "가입하기"
    static let loginText = "로그인"
    static let defaultFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    static let minPasswordLength = 8
    
    static func getHightlightedString(text: String, highlightedText hText: String, fontFamilyName ffName: String, size: CGFloat) -> NSMutableAttributedString {
        let attributedStr = NSMutableAttributedString(string: text, attributes: [.font : UIFont(name: ffName + "-Regular", size: size) ?? defaultFont])
        let range = attributedStr.mutableString.range(of: hText)
        attributedStr.addAttribute(.font, value: UIFont(name: ffName+"-Bold", size: size) ?? defaultFont, range: range)
        return attributedStr
    }
}
