//
//  BottomBarView.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

protocol BottomBarViewActionDelegate : AnyObject {
    func mainButtonTapped()
    func textLabelTapped()
}

protocol BottomBarViewSourceDelegate {
    func setButtonText(text: String)
    func setLabelText(text: String, underLinedText : String?, size: CGFloat)
}

class BottomBarView: UIView {
    @IBOutlet weak var mainButton : UIButton!
    @IBOutlet weak var textLabel : UILabel!
    
    weak var delegate : BottomBarViewActionDelegate!
    
    private var lblFontSize : CGFloat!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainButton.layer.cornerRadius = 10
    }
    
    @IBAction func onMainButtonClick(_ sender: UIButton) {
        delegate.mainButtonTapped()
    }
}

extension BottomBarView: BottomBarViewSourceDelegate {
    func setButtonText(text: String) {
        mainButton.setTitle(text, for: .normal)
    }
    
    func setLabelText(text: String, underLinedText : String? = nil, size: CGFloat) {
        let font = UIFont(name: "Roboto-Regular", size: size)
        if let uText = underLinedText {
            let attributedText = NSMutableAttributedString(string: text, attributes: [.font : font ?? Helper.defaultFont, .foregroundColor : UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)])
            print("Attributed Text = \(attributedText)")
            let range = attributedText.mutableString.range(of: uText)
            print("Range = \(range)")
            attributedText.addAttributes([.underlineStyle : NSUnderlineStyle.single.rawValue, .underlineColor : UIColor(red: 0.231, green: 0.157, blue: 0.427, alpha: 1)], range: range)
            
            print("Now attributed text = \(attributedText)")
            
            textLabel.attributedText = attributedText
        } else {
            textLabel.text = text
            textLabel.font = font
            textLabel.textColor = UIColor(red: 0.231, green: 0.157, blue: 0.427, alpha: 1)
        }
    }
}
