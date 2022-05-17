//
//  RegistartionViewController.swift
//  JointStoreProject
//
//  Created by Игорь Богданов on 15.05.2022.
//

import UIKit

class RegistartionViewController: UIViewController {
    
    let authManager = AuthManager.shared
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    @IBAction func registerNewAccount() {
       if authManager.addUser(login: loginTextField.text ?? "client",
                              password: passwordTextField.text ?? "qwerty") == true {
           logginIn()
       }
    }
    
    func logginIn() {
        if authManager.login(login: loginTextField.text ?? "",
                             password: passwordTextField.text ?? ""
        ) == true {
            performSegue(withIdentifier: "", sender: registerationButton)
            print("login success")
        } else {
            setAlert(header: "Упс", body: "Кажется вы уже зарегистрированы")
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

extension RegistartionViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
            return true
        } else if loginTextField.hasText == false || passwordTextField.hasText == false {
            setAlert(header: "Упс", body: "Проверьте заполенение всех полей")
            return true
        } else {
            registerNewAccount()
            print("registration completed")
            return true
        }
    }
}
