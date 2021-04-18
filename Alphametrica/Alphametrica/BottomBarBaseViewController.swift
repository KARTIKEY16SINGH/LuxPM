//
//  BottomBarBaseViewController.swift
//  Alphametrica
//
//  Created by Iron Man on 18/04/21.
//

import UIKit

class BottomBarBaseViewController : UIViewController {
    var bottomBarDelegate : BottomBarViewSourceDelegate!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bottomBarView = segue.destination.view.subviews.first as? BottomBarView {
            bottomBarDelegate = bottomBarView
            bottomBarView.delegate = self
        }
    }
}

extension BottomBarBaseViewController: BottomBarViewActionDelegate {
    @objc func mainButtonTapped() {
    }
    
    @objc func textLabelTapped() {
    }
}
