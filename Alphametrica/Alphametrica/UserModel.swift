//
//  UsedModel.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import Foundation

struct UserModel {
    private(set) var name : String?
    private(set) var emailId : String?
    private(set) var phone : String?
    private(set) var password : String?
    private(set) var dob : String?
    
    mutating func updateName(text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        name = text
        return true
    }
    
    mutating func updateEmail(text: String) -> Bool {
        if text.contains("@") && text.contains(".com") {
            emailId = text
            return true
        }
        return false
    }
    
    mutating func updatePhone(text: String) -> Bool {
        let phoneRegex = "[a-zA-Z]"
        let phoneTest = text.range(of: phoneRegex, options: .regularExpression)
        print("Phone Test = \(phoneTest)")
        if phoneTest != nil {
            return false
        }
        phone = text
        return true
    }
    
    mutating func updateDate(text: String) {
        dob = text
    }
    
    mutating func updatePassword(text: String) -> [Bool] {
        var res = [Bool]()
        var isOk = true
        if text.count >= Helper.minPasswordLength {
            res.append(true)
        } else {
            res.append(false)
            isOk = false
        }
        
        var regex = "[A-Z]"
        if let _ = text.range(of: regex, options: .regularExpression) {
            res.append(true)
        } else {
            res.append(false)
            isOk = false
        }
        
        regex = "[0-9]"
        if let _ = text.range(of: regex, options: .regularExpression) {
            res.append(true)
        } else {
            res.append(false)
            isOk = false
        }
        
        regex = "[^a-zA-z0-9]"
        if let _ = text.range(of: regex, options: .regularExpression) {
            res.append(true)
        } else {
            res.append(false)
            isOk = false
        }
        
        if isOk {
            password = text
        }
        print("Res = \(res)")
        return res
    }
}
