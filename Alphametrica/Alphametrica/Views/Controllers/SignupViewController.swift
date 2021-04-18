//
//  SignupViewController.swift
//  Alphametrica
//
//  Created by Iron Man on 17/04/21.
//

import UIKit

class SignupViewController: BottomBarBaseViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewContainer : UIView!
    @IBOutlet weak var tncButton : UIButton!
    @IBOutlet weak var tncLabel : UILabel!
    
    weak var collectionView : UICollectionView!
    
    private var userData = UserModel()
    private var entryData : [AccountInfoEntryTypeModel]!
    private var isTncAgreed : Bool = false
    private var passField : String?
    private var cmPassField : String?
    
    private let rowHeight : CGFloat = 88.5
    private var lastContentOffest : CGPoint = CGPoint.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        bottomBarDelegate.setButtonText(text: Helper.signUpText)
        bottomBarDelegate.setLabelText(text: Helper.alreadyAccountText, underLinedText: Helper.loginText, size: 16)
        entryData = DataManager.shared.createModel()
        tableView.register(UINib(nibName: "SignupTableViewCell", bundle: Bundle(for: SignupViewController.self)), forCellReuseIdentifier: "signupTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = rowHeight
        tableView.allowsSelection = false
        tableView.separatorColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        tableViewHeightConstraint.constant = rowHeight * CGFloat(entryData.count)
        self.setupForKeyboardUse()
        tncLabel.attributedText = GUIManager.getHightlightedString(text: Helper.tncText, highlightedText: Helper.tncBoldText, fontFamilyName: "Roboto", size: 12)
        tncButton.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        tncButton.layer.cornerRadius = 5
    }
    
    @IBAction func tncButtonClicked(_ sender: UIButton) {
        if !isTncAgreed {
            tncButton.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.1568627451, blue: 0.4274509804, alpha: 1)
        } else {
            tncButton.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        }
        isTncAgreed = !isTncAgreed
    }
    
    
    override func keyBoardDidHide(notification : NSNotification) {
        scrollView.setContentOffset(lastContentOffest, animated: true)
    }
    
    override func mainButtonTapped() {
        if isTncAgreed {
            var text : String? = nil
//            print("PassField = \(passField) cmPassField = \(cmPassField)")
            if userData.name == nil || !DataManager.shared.checkName(text: userData.name!) {
                text = "Name is empty"
            } else if userData.phone == nil || !DataManager.shared.checkPhone(text: userData.phone!) {
                text = "Please enter a valid phone number"
            } else if userData.dob == nil || !DataManager.shared.checkDate(text: userData.dob!) {
                text = "Please enter a valid date of birth"
            } else if userData.emailId == nil || !DataManager.shared.checkEmail(text: userData.emailId!) {
                text = "Please enter a vaild email id"
            } else if userData.password == nil || passField != cmPassField || !DataManager.shared.checkPassword(text: (passField)!) {
                text = "Please enter a valid password"
            }
            
            if text == nil {
                textLabelTapped()
            } else {
                GUIManager.showAlert(message: text!, presenter: self)
            }
        } else {
            GUIManager.showAlert(message: "Please agree to Terms & Condition", presenter: self)
        }
    }
    
    override func textLabelTapped() {
        navigationController?.pushViewController(GUIManager.getLonginViewController(), animated: true)
    }
    
    @objc func textFieldDidChanged(sender: UITextField) {
        print("Text = \(String(describing: sender.text))")
        switch entryData[Int(sender.tag)].entryType {
        case .name:
            userData.updateName(sender.text)
        case .phoneNumber:
            userData.updatePhone(sender.text)
        case .date:
            userData.updateDOB(sender.text)
        case .email:
            userData.updateEmail(sender.text)
        case .password:
            passField = sender.text
            userData.updatePassword(sender.text)
            DataManager.shared.modifyPassword(text: sender.text!)
        case .confirmPassword:
            cmPassField = sender.text
        }
    }
}

extension SignupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "signupTableViewCell", for: indexPath) as? SignupTableViewCell else {return UITableViewCell()}
        
        cell.setupViews(entryType: entryData[indexPath.row])
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        cell.textField.addTarget(self, action: #selector(textFieldDidChanged(sender:)), for: .editingChanged)
        return cell
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let point : CGFloat = tableView.layer.frame
            .origin.y + (rowHeight * CGFloat(Int(textField.tag)))
        lastContentOffest = scrollView.contentOffset
        scrollView.setContentOffset(CGPoint(x: 0, y: point), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrollView.setContentOffset(lastContentOffest, animated: true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if entryData[Int(textField.tag)].entryType == .date && !string.isEmpty {
            guard let count = textField.text?.count else {return true}
            print("Count = \(count)")
            if(count >= 10) {
                return false
            }
            if count == 2 || count == 5 {
                textField.text! += "-"
            }
                
        }
        return true
    }
}
