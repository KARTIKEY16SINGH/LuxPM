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
    
    mutating func updateName(_ text: String?) {
        name = text
    }
    
    mutating func updateEmail(_ text: String?) {
        emailId = text
    }
    
    mutating func updatePhone(_ text: String?) {
        phone = text
    }
    
    mutating func updatePassword(_ text: String?) {
        password = text
    }
    
    mutating func updateDOB(_ text: String?) {
        dob = text
    }
}
