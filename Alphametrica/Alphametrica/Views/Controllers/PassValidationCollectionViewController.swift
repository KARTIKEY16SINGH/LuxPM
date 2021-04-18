//
//  PassValidationCollectionViewController.swift
//  Alphametrica
//
//  Created by Iron Man on 18/04/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class PassValidationCollectionViewController: UICollectionViewController {

    private var data : [ValidationModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = DataManager.shared.createValidationModel()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UINib(nibName: "ValidationCollectionViewCell", bundle: nibBundle), forCellWithReuseIdentifier: "validationCell")
        self.collectionView.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(vailidityUpdated(notification:)), name: .PasswordValidityUpdated, object: nil)
    }

    @objc func vailidityUpdated(notification : NSNotification) {
        data = DataManager.shared.validationData
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "validationCell", for: indexPath) as! ValidationCollectionViewCell
        cell.button.isSelected = data[indexPath.row].isValid
        cell.titleLabel.attributedText = GUIManager.getHightlightedString(text: data[indexPath.row].validationName, highlightedText: data[indexPath.row].boldValidationName, fontFamilyName: "Roboto", size: 11)
        return cell
    }

}
