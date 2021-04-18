//
//  ViewController.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

class ViewController: BottomBarBaseViewController {

    @IBOutlet weak var bottomBarContainerView : UIView!
    @IBOutlet weak var firstLabel : UILabel!
    @IBOutlet weak var secondLabel : UILabel!
    
    private let sampleText1 = "Stay on the top of your finance"
    private let sampleText2 = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam "
    private let sHightLightedText1 = "of your finance"
    private let sHightLightedText2 = "consetetur sadipscing elitr, sed diam "
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.attributedText = Helper.getHightlightedString(text: sampleText1, highlightedText: sHightLightedText1, fontFamilyName: "Lato", size: 23)
        secondLabel.attributedText = Helper.getHightlightedString(text: sampleText2, highlightedText: sHightLightedText2, fontFamilyName: "Merriweather", size: 14)
        bottomBarDelegate.setButtonText(text: Helper.signUpText)
        bottomBarDelegate.setLabelText(text: Helper.loginText, underLinedText: nil, size: 16)
    }
}

extension ViewController {
    override func mainButtonTapped() {
        let vc = UIStoryboard(name: "SignupStoryboard", bundle: nibBundle).instantiateViewController(identifier: "signupStoryboard")
        print("Navigation Controller = \(navigationController)")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func textLabelTapped() {
        let vc = UIStoryboard(name: "LoginStoryboard", bundle: nibBundle).instantiateInitialViewController()
        navigationController?.pushViewController(vc!, animated: true)
    }
}
