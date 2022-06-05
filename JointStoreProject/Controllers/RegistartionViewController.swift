//
//  RegistartionViewController.swift
//  JointStoreProject
//
//  Created by Игорь Богданов on 15.05.2022.
//

import UIKit

class RegistartionViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerationButton: UIButton!
    
    var delegate: LoginViewControllerDelegate!
    
    private let authManager = AuthManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func registerNewAccount() {
       if loginTextField.hasText == false || passwordTextField.hasText == false {
           setAlert(header: "Упс", body: "Проверьте заполенение всех полей")
       } else if authManager.addUser(login: loginTextField.text ?? "",
                                     password: passwordTextField.text ?? "") {
           dismiss(animated: true, completion: {
               self.delegate.login(login: self.loginTextField.text ?? "",
                                   password: self.passwordTextField.text ?? "") }
           )
       } else {
           setAlert(header: "Упс", body: "Кажется вы уже зарегистрированы")
       }
    }
    
   private func setAlert(header: String, body: String) {
        let alert = UIAlertController(title: header,
                                      message: body,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
        } else if loginTextField.hasText == false || passwordTextField.hasText == false {
            setAlert(header: "Упс", body: "Проверьте заполенение всех полей")
        } else {
            registerNewAccount()
        }
        
        return true
    }
}
