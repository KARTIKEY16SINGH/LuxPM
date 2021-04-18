//
//  LoginViewController.swift
//  Alphametrica
//
//  Created by Iron Man on 18/04/21.
//

import UIKit

class LoginViewController: BottomBarBaseViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var forgetPasswordLabel : UILabel!
    
    private var entryData : [AccountInfoEntryTypeModel]!
    private var loginField : UITextField?
    private var pwdField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryData = DataManager.shared.createLoginModel()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    private func setupViews() {
        tableView.register(UINib(nibName: "LoginTableViewCell", bundle: Bundle(for: LoginViewController.self)), forCellReuseIdentifier: "loginTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.allowsSelection = false
        forgetPasswordLabel.attributedText = GUIManager.getHightlightedString(text: "비밀번호 찾기", highlightedText: "찾기", fontFamilyName: "Roboto", size: 14)
        bottomBarDelegate.setButtonText(text: Helper.loginText)
        bottomBarDelegate.setLabelText(text: "계정이 없으신가요?   가입하기", underLinedText: Helper.signUpText, size: 14)
        setupForKeyboardUse()
    }
    
    override func mainButtonTapped() {
        guard let _ = loginField?.text, let _ = pwdField?.text else {
            showLoginFailAlert()
            return
        }
        if DataManager.shared.validateLogin(emaild: (loginField?.text)!, pwd: (pwdField?.text)!) {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.white
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showLoginFailAlert()
        }
    }
    
    private func showLoginFailAlert() {
        GUIManager.showAlert(message: "Either EmmailID or Password is not correct", presenter: self)
    }
    
    override func textLabelTapped() {
        navigationController?.pushViewController(GUIManager.getSignupViewController(), animated: true)
    }
}

extension LoginViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginTableViewCell", for: indexPath) as! SignupTableViewCell
        cell.setupViews(entryType: entryData[indexPath.row])
        if entryData[indexPath.row].entryType == .email {
            loginField = cell.textField
        }
        
        if entryData[indexPath.row].entryType == .password {
            pwdField = cell.textField
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.layer.frame.height/CGFloat(entryData.count)
    }
}
