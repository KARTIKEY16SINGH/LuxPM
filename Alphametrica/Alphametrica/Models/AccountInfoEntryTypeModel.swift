//
//  SignupModel.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

struct AccountInfoEntryTypeModel {
    enum EntryType {
        case name
        case phoneNumber
        case date
        case email
        case password
        case confirmPassword
    }
    
    var titleText : String
    var placeholderText : String
    var entryType : EntryType
    var highlightedText : String?
    var iconImage : UIImage?
}
