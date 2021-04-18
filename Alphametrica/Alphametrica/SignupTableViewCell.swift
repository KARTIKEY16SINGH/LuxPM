//
//  SignupTableViewCell.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

class SignupTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var iconImage : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupViews(entryType : SignupEntryTypeModel) {
        if let _ = iconImage {
            iconImage?.image = entryType.iconImage
        }
        if entryType.highlightedText == nil {
            titleLabel.text = entryType.titleText
        } else {
            titleLabel.attributedText = Helper.getHightlightedString(text: entryType.titleText, highlightedText: entryType.highlightedText!, fontFamilyName: "Roboto", size: 16)
        }
        textField.placeholder = entryType.placeholderText
        textField.isSecureTextEntry = false
        textField.autocorrectionType = .no
        switch entryType.entryType {
        case .name:
            textField.textContentType = .name
            textField.keyboardType = .default
        case .phoneNumber:
            textField.textContentType = .telephoneNumber
            textField.keyboardType = .phonePad
        case .date:
            textField.textContentType = .none
            textField.keyboardType = .numberPad
        case .email:
            textField.textContentType = .emailAddress
            textField.keyboardType = .emailAddress
        case .password:
            textField.textContentType = .password
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
        }
    }
}
