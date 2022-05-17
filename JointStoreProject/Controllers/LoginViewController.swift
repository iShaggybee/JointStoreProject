//
//  LoginViewController.swift
//  JointStoreProject
//
//  Created by Игорь Богданов on 15.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    let authManager = AuthManager.shared
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    @IBAction func authorizing() {
        logginIn()
    }
    
    @IBAction func remindInfo() {
        let users = authManager.getUsersInfo()
        let userIndex = users.firstIndex(where: {$0.login == loginTextField.text})
        
        switch userIndex {
            
        case .none:
            setAlert(header: "Упс",
                     body: "Такого пользователя нет. Попробуйте зарегистрироваться")
        case .some(_):
            let userInfo = users[userIndex ?? 0]
            if userIndex == 0 {
                setAlert(header: "Вот дежурные данные",
                         body: "Логин: \(userInfo.login), пароль: \(userInfo.password)")
            } else {
                setAlert(header: "Ничего страшгого,\(userInfo.login)", body: "Ваш пароль: \(userInfo.password)")
            }
        }
    }
    
    func logginIn() {
        if authManager.login(login: loginTextField.text ?? "",
                             password: passwordTextField.text ?? ""
        ) == true {
            performSegue(withIdentifier: "", sender: loginButton)
            print("login comleted")
        } else {
            setAlert(header: "Incorrect user info", body: "Check if your username or password is correct")
        }
    }
    
    func setAlert(header: String, body: String) {
        let alert = UIAlertController(title: header,
                                      message: body,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
            logginIn()
            return true
        }
    }
}

