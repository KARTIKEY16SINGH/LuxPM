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
    static let alreadyAccountText = "이미 계정이 있으신가요?  로그인"
    static let tncText = "이용약관에 동의합니다"
    static let tncBoldText = "동의합니다"
    static let reqPassLength = "최소 8자 이상"
    static let reqPassLengthBold = "8자"
    static let reqUpperCaseLetter = "최소 하나의 대문자"
    static let reqUpperCaseLetterBold = "하나의"
    static let reqPassNumber = "최소 하나의 숫자"
    static let reqPassNumberBold = "하나의"
    static let reqPassSpecialChar = "최소 하나의 특수문자"
    static let reqPassSpecialCharBold = "하나의"
    
    static let defaultFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    static let minPasswordLength = 8
}

extension Notification.Name {
    static let PasswordValidityUpdated = Notification.Name.init("PasswordValidityUpdated")
}
