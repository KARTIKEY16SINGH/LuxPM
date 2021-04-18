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
    private var tappedText : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainButton.layer.cornerRadius = 10
        textLabel.isUserInteractionEnabled = true
        textLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(gesture:))))
    }
    
    @IBAction func onMainButtonClick(_ sender: UIButton) {
        delegate.mainButtonTapped()
    }
    
    @objc private func labelTapped(gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: textLabel)
        if tappedText == nil || touchPoint.x >= (textLabel.layer.frame.width * 0.80) {
            delegate.textLabelTapped()
        }
//        guard let _ = tappedText else {
//            delegate.textLabelTapped()
//            return
//        }
//        let range = (textLabel.text! as NSString).range(of: tappedText!)
//        if gesture.didTapAttributedTextInLabel(label: textLabel, inRange: range) {
//            delegate.textLabelTapped()
//        }
    }
}

extension BottomBarView: BottomBarViewSourceDelegate {
    func setButtonText(text: String) {
        mainButton.setTitle(text, for: .normal)
    }

    func setLabelText(text: String, underLinedText : String? = nil, size: CGFloat) {
        let font = UIFont(name: "Roboto-Regular", size: size)
        if let uText = underLinedText {
            tappedText = uText
            let attributedText = NSMutableAttributedString(string: text, attributes: [.font : font ?? Helper.defaultFont, .foregroundColor : UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)])
            print("Attributed Text = \(attributedText)")
            let range = attributedText.mutableString.range(of: uText)
            print("Range = \(range)")
            attributedText.addAttributes([.underlineStyle : NSUnderlineStyle.single.rawValue, .underlineColor : UIColor(red: 0.231, green: 0.157, blue: 0.427, alpha: 1)], range: range)

            print("Now attributed text = \(attributedText)")

            textLabel.attributedText = attributedText
        } else {
            tappedText = nil
            textLabel.text = text
            textLabel.font = font
            textLabel.textColor = UIColor(red: 0.231, green: 0.157, blue: 0.427, alpha: 1)
        }
    }
}
/*
 extension UITapGestureRecognizer {

     func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
         // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
         let layoutManager = NSLayoutManager()
         let textContainer = NSTextContainer(size: CGSize.zero)
         let textStorage = NSTextStorage(attributedString: label.attributedText!)

         // Configure layoutManager and textStorage
         layoutManager.addTextContainer(textContainer)
         textStorage.addLayoutManager(layoutManager)

         // Configure textContainer
         textContainer.lineFragmentPadding = 0.0
         textContainer.lineBreakMode = label.lineBreakMode
         textContainer.maximumNumberOfLines = label.numberOfLines
         let labelSize = label.bounds.size
         textContainer.size = labelSize

         // Find the tapped character location and compare it to the specified range
         let locationOfTouchInLabel = self.location(in: label)
         let textBoundingBox = layoutManager.usedRect(for: textContainer)
         //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                               //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
         let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

         //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                         // locationOfTouchInLabel.y - textContainerOffset.y);
         let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
         let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
         return NSLocationInRange(indexOfCharacter, targetRange)
     }

 }
 */
