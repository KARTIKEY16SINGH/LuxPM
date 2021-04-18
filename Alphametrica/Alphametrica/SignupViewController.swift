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
    weak var collectionView : UICollectionView!
    
    private var userData = UserModel()
    private var entryData : [SignupEntryTypeModel]!
    
    private let rowHeight : CGFloat = 88.5
    private var lastContentOffest : CGPoint = CGPoint.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        bottomBarDelegate.setButtonText(text: Helper.signUpText)
        bottomBarDelegate.setLabelText(text: "이미 계정이 있으신가요?  로그인", underLinedText: Helper.loginText, size: 16)
        entryData = SignupModel().createModel()
        tableView.register(UINib(nibName: "SignupTableViewCell", bundle: Bundle(for: SignupViewController.self)), forCellReuseIdentifier: "signupTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = rowHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        tableViewHeightConstraint.constant = rowHeight * CGFloat(entryData.count)
        addObserverToHideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardDidHide(notification : NSNotification) {
        scrollView.setContentOffset(lastContentOffest, animated: true)
    }
    
    private func updateUser(textField: UITextField) {
        guard let text = textField.text else {return}
        switch entryData[Int(textField.tag)].entryType {
        case .name:
            userData.updateName(text: text)
        case .phoneNumber:
            userData.updatePhone(text: text)
        case .date:
            userData.updateDate(text: text)
        case .email:
            userData.updateEmail(text: text)
        case .password:
            userData.updatePassword(text: text)
        }
    }
    
    override func mainButtonTapped() {
        
    }
    
    override func textLabelTapped() {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        navigationController?.pushViewController(vc, animated: true)
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
        updateUser(textField: textField)
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
        updateUser(textField: textField)
        return true
    }
}

extension UIViewController {
    func addObserverToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
