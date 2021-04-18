//
//  SignupModel.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

struct SignupEntryTypeModel {
    enum EntryType {
        case name
        case phoneNumber
        case date
        case email
        case password
    }
    
    var titleText : String
    var placeholderText : String
    var entryType : EntryType
    var highlightedText : String?
    var iconImage : UIImage?
}

struct SignupModel {
//    var entryTypes : [SignupEntryTypeModel]
    func createModel() -> [SignupEntryTypeModel] {
        var entryTypes = [SignupEntryTypeModel]()
        
        entryTypes.append(.init(titleText: "이름", placeholderText: "이채민", entryType: .name))
        entryTypes.append(.init(titleText: "휴대폰 번호", placeholderText: "+82 111 1111111", entryType: .phoneNumber, highlightedText: "번호"))
        entryTypes.append(.init(titleText: "생년월일", placeholderText: "mm - dd-yyyy", entryType: .date))
        entryTypes.append(.init(titleText: " Email", placeholderText: "john.doe@alphametics.com", entryType: .email))
        entryTypes.append(.init(titleText: "비밀번호", placeholderText: "Enter Password", entryType: .password))
        entryTypes.append(.init(titleText: "비밀번호 확인", placeholderText: "Confirm Password", entryType: .password, highlightedText: "확인"))
        
        return entryTypes
    }
    
    func createLoginModel() -> [SignupEntryTypeModel] {
        var entryTypes = [SignupEntryTypeModel]()
        entryTypes.append(.init(titleText: " Email", placeholderText: "john.doe@alphametics.com", entryType: .email, iconImage: #imageLiteral(resourceName: "emailIcon")))
        entryTypes.append(.init(titleText: "비밀번호", placeholderText: "Enter Password", entryType: .password, iconImage: #imageLiteral(resourceName: "lockIcon")))
        
        return entryTypes
    }
    
}
