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
    
    weak var bottomBarView : BottomBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        bottomBarView = (segue.destination.view.subviews.first as! BottomBarView)
    }
     
}

