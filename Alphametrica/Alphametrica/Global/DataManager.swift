//
//  DataManager.swift
//  Alphametrica
//
//  Created by Iron Man on 18/04/21.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private init() {}
    var validationData : [ValidationModel]!
    
    func createModel() -> [AccountInfoEntryTypeModel] {
        var entryTypes = [AccountInfoEntryTypeModel]()
        
        entryTypes.append(.init(titleText: "이름", placeholderText: "이채민", entryType: .name))
        entryTypes.append(.init(titleText: "휴대폰 번호", placeholderText: "+82 111 1111111", entryType: .phoneNumber, highlightedText: "번호"))
        entryTypes.append(.init(titleText: "생년월일", placeholderText: "mm - dd-yyyy", entryType: .date))
        entryTypes.append(.init(titleText: " Email", placeholderText: "john.doe@alphametics.com", entryType: .email))
        entryTypes.append(.init(titleText: "비밀번호", placeholderText: "Enter Password", entryType: .password))
        entryTypes.append(.init(titleText: "비밀번호 확인", placeholderText: "Confirm Password", entryType: .confirmPassword, highlightedText: "확인"))
        
        return entryTypes
    }
    
    func createLoginModel() -> [AccountInfoEntryTypeModel] {
        var entryTypes = [AccountInfoEntryTypeModel]()
        entryTypes.append(.init(titleText: " Email", placeholderText: "john.doe@alphametics.com", entryType: .email, iconImage: #imageLiteral(resourceName: "emailIcon")))
        entryTypes.append(.init(titleText: "비밀번호", placeholderText: "Enter Password", entryType: .password, iconImage: #imageLiteral(resourceName: "lockIcon")))
        
        return entryTypes
    }
    
    func checkName(text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        return true
    }
    
    func checkEmail(text: String) -> Bool {
        if text.contains("@") && text.contains(".com") {
            return true
        }
        return false
    }
    
    func checkPhone(text: String) -> Bool {
        let phoneRegex = "[a-zA-Z]"
        let phoneTest = text.range(of: phoneRegex, options: .regularExpression)
        print("Phone Test = \(String(describing: phoneTest))")
        if phoneTest != nil {
            return false
        }
        return true
    }
    
    func checkDate(text: String) -> Bool {
        if text.count == 10 && text.split(separator: "-").count == 3 {
            return true
        }
        return false
    }
    
    func checkPassword(text: String) -> Bool {
        if text.count < Helper.minPasswordLength {
            return false
        }
        
        var regex = "[A-Z]"
        if text.range(of: regex, options: .regularExpression) == nil {
            return false
        }
        
        regex = "[0-9]"
        if text.range(of: regex, options: .regularExpression) == nil {
            return false
        }
        
        regex = "[^a-zA-z0-9]"
        if text.range(of: regex, options: .regularExpression) == nil {
            return false
        }
        
        return true
    }
    
    func modifyPassword(text : String) {
        var res = [Bool]()
        if text.count >= Helper.minPasswordLength {
            res.append(true)
        } else {
            res.append(false)
        }
        
        var regex = "[A-Z]"
        if let _ = text.range(of: regex, options: .regularExpression) {
            res.append(true)
        } else {
            res.append(false)
        }
        
        regex = "[0-9]"
        if let _ = text.range(of: regex, options: .regularExpression) {
            res.append(true)
        } else {
            res.append(false)
        }
        
        regex = "[^a-zA-z0-9]"
        if let _ = text.range(of: regex, options: .regularExpression) {
            res.append(true)
        } else {
            res.append(false)
        }
        print("Res = \(res)")
        
        updateValidationModel(result: res)
    }
    
    func createValidationModel() -> [ValidationModel] {
        var data = [ValidationModel]()
        
        data.append(.init(validationName: Helper.reqPassLength, boldValidationName: Helper.reqPassLengthBold, isValid: false))
        data.append(.init(validationName: Helper.reqUpperCaseLetter, boldValidationName: Helper.reqUpperCaseLetterBold, isValid: false))
        data.append(.init(validationName: Helper.reqPassNumber, boldValidationName: Helper.reqPassNumberBold, isValid: false))
        data.append(.init(validationName: Helper.reqPassSpecialChar, boldValidationName: Helper.reqPassSpecialCharBold, isValid: false))
        
        validationData = data
        
        return data
    }
    
    func updateValidationModel(result : [Bool]) {
        for (index, res) in result.enumerated() {
            validationData[index].isValid = res
        }
        NotificationCenter.default.post(name: .PasswordValidityUpdated, object: nil)
    }
    
    func validateLogin(emaild : String, pwd : String) -> Bool {
        let adminId = "test@luxpmsoft.com"
        let adminPwd = "test1234!"
        
        if emaild.elementsEqual(adminId) && pwd.elementsEqual(adminPwd) {
            return true
        }
        return false
    }
}
