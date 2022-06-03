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
    @IBOutlet weak var labelStackView: UIStackView!
    var backgroundView: UIView!
    var logoStackView: UIStackView!
    var logoTitleLabel: UILabel!
    
    private let authManager = AuthManager.shared
    var needAnimate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        setupViewForAnimation()
        
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
        
        guard needAnimate else {return}
        
        logoTitleLabel.isHidden = true
        
        let newCenterLogo = labelStackView.frame.origin.y / 2
        let maxWidth = loginTextField.bounds.width * 0.75
        let maxSizeToBoard = (newCenterLogo - 40) * 2
        
        NSLayoutConstraint.activate([
            logoStackView.widthAnchor.constraint(equalToConstant: min(maxWidth, maxSizeToBoard)),
            logoStackView.heightAnchor.constraint(equalToConstant: min(maxWidth, maxSizeToBoard)),
            logoStackView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: newCenterLogo)
        ])

        UIView.animate(withDuration: 1.5, delay: 0) {
            self.backgroundView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.backgroundView.isHidden = true
        }
        
        needAnimate = false
    }
    
    func setupViewForAnimation() {
        
        backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.frame.origin = CGPoint(x: 0, y: 0)
        backgroundView.backgroundColor = .white
        view.addSubview(backgroundView)
        
        logoStackView = UIStackView(frame: CGRect())
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        logoStackView.axis = .vertical
        logoStackView.alignment = .center
        logoStackView.distribution = .fill
        logoStackView.spacing = 24
        view.addSubview(logoStackView)
        
        let imageView = UIImageView(image: UIImage(named: "number4"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        logoStackView.addArrangedSubview(imageView)
        
        logoTitleLabel = UILabel()
        logoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        logoTitleLabel.font = UIFont.systemFont(ofSize: 42)
        logoTitleLabel.text = "Четверочка"
        logoStackView.addArrangedSubview(logoTitleLabel)
        
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalToConstant: 240),
            imageView.heightAnchor.constraint(equalToConstant: 212),

            logoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

