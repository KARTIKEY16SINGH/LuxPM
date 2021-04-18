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
    
    private var entryData : [SignupEntryTypeModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryData = SignupModel().createLoginModel()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    private func setupViews() {
        tableView.register(UINib(nibName: "LoginTableViewCell", bundle: Bundle(for: LoginViewController.self)), forCellReuseIdentifier: "loginTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.allowsSelection = false
        forgetPasswordLabel.attributedText = Helper.getHightlightedString(text: "비밀번호 찾기", highlightedText: "찾기", fontFamilyName: "Roboto", size: 14)
        bottomBarDelegate.setButtonText(text: Helper.loginText)
        bottomBarDelegate.setLabelText(text: "계정이 없으신가요?   가입하기", underLinedText: Helper.signUpText, size: 14)
    }
    
    override func mainButtonTapped() {
        
//        navigationController?.pushViewController(UIViewController(), animated: true)
        
        let alert = UIAlertController.init(title: "Alert!", message: "Incorrect EmailId or Password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func textLabelTapped() {
        let vc = UIStoryboard(name: "SignupStoryboard", bundle: Bundle(for: LoginViewController.self)).instantiateInitialViewController()!
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginTableViewCell", for: indexPath) as! SignupTableViewCell
        cell.setupViews(entryType: entryData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.layer.frame.height/CGFloat(entryData.count)
    }
}
