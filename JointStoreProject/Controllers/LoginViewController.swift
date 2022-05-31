//
//  LoginViewController.swift
//  JointStoreProject
//
//  Created by Игорь Богданов on 15.05.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func login(login: String, password: String)
}

class LoginViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var widthLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var axisYLogoConstaint: NSLayoutConstraint!
    @IBOutlet weak var logoTitleLabel: UILabel!
    
    private let authManager = AuthManager.shared
    var needAimate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let registrationVC = segue.destination as? RegistartionViewController else {
            return
        }
        
        registrationVC.delegate = self
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        authManager.logout()
        
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func authorizing() {
        login()
    }
    
    @IBAction func remindInfo() {
        let users = authManager.getUsersInfo()
       
        if loginTextField.hasText == false {
            setAlert(header: "Вот дежурные данные",
                     body: "Логин: \(users[0].login), пароль: \(users[0].password)")
        }
        
        guard let userIndex = users.firstIndex(where: {$0.login == loginTextField.text}) else {
            setAlert(header: "Упс",
                     body: "Пользователя с логином \(loginTextField.text?.uppercased() ?? "") не существует")
            return
        }
        
        let userInfo = users[userIndex]
        setAlert(header: "Ничего страшного, \(userInfo.login)", body: "Ваш пароль: \(userInfo.password)")
            
    }
    
   private func setAlert(header: String, body: String) {
        let alert = UIAlertController(title: header,
                                      message: body,
                                      preferredStyle: .alert)
       
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func login() {
        if authManager.login(login: loginTextField.text ?? "",
                             password: passwordTextField.text ?? ""
        ) {
            performSegue(withIdentifier: "SuccessLoginSegue", sender: nil)
        } else {
            setAlert(header: "Упс", body: "Проверьте правильность введенных данных")
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
            
            return true
        } else {
            login()
            
            return true
        }
    }
}

extension LoginViewController: LoginViewControllerDelegate {
    func login(login: String, password: String) {
        if authManager.login(login: login, password: password) {
            performSegue(withIdentifier: "SuccessLoginSegue", sender: nil)
        } else {
            setAlert(header: "Упс", body: "Не удалось авторизоваться")
        }
    }
}

extension LoginViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        guard needAimate else {return}
        self.widthLogoConstraint.constant = 80
        self.axisYLogoConstaint.constant = -200
        UIView.animate(withDuration: 1, delay: 0) {
            self.backgroundView.alpha = 0
            self.logoTitleLabel.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.backgroundView.isHidden = true
        }
        
        needAimate = false
    }
}

