//
//  LoginViewController.swift
//  JointStoreProject
//
//  Created by Игорь Богданов on 15.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    let authManager = AuthManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
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
                     body: "Такого пользователя нет. Попробуйте зарегистрироваться")
            return
        }
        
        let userInfo = users[userIndex]
        setAlert(header: "Ничего страшгого,\(userInfo.login)", body: "Ваш пароль: \(userInfo.password)")
            
    }
    
    func setAlert(header: String, body: String) {
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
            performSegue(withIdentifier: "", sender: loginButton)
            print("login comleted")
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

