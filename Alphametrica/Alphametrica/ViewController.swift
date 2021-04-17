//
//  ViewController.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomBarContainerView : UIView!
    @IBOutlet weak var firstLabel : UILabel!
    @IBOutlet weak var secondLabel : UILabel!
    
    weak var bbSourceDelegate : BottomBarView!
    
    private let sampleText1 = "Stay on the top of your finance"
    private let sampleText2 = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam "
    private let sHightLightedText1 = "of your finance"
    private let sHightLightedText2 = "consetetur sadipscing elitr, sed diam "
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.attributedText = Helper.getHightlightedString(text: sampleText1, highlightedText: sHightLightedText1, fontFamilyName: "Lato", size: 23)
        secondLabel.attributedText = Helper.getHightlightedString(text: sampleText2, highlightedText: sHightLightedText2, fontFamilyName: "Merriweather", size: 14)
        bbSourceDelegate.setButtonText(text: Helper.signUpText)
        bbSourceDelegate.setLabelText(text: Helper.loginText, size: 16)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bottomBarView = (segue.destination.view.subviews.first as! BottomBarView)
        bbSourceDelegate = bottomBarView
        bottomBarView.delegate = self
    }
}

extension ViewController: BottomBarViewActionDelegate {
    func mainButtonTapped() {
        
    }
    
    func textLabelTapped() {
        
    }
}
