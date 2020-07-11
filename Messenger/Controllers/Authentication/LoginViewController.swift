//
//  LoginViewController.swift
//  Messenger
//
//  Created by José Pinto on 2020-07-08.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginScreenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.backgroundColor = .white
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log In"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(registerButtonPressed))
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        emailTextField.delegate = self
        passwordTextField.delegate  = self
        
        // Add subviews
        view.addSubview(loginScreenScrollView)
        loginScreenScrollView.addSubview(logoImageView)
        loginScreenScrollView.addSubview(emailTextField)
        loginScreenScrollView.addSubview(passwordTextField)
        loginScreenScrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set frame
        loginScreenScrollView.frame = view.bounds
        let size = loginScreenScrollView.width / 3
        logoImageView.frame = CGRect(x: (loginScreenScrollView.width - size) / 2, y: 20, width: size, height: size)
        emailTextField.frame = CGRect(x: 30, y: logoImageView.bottom + 10, width: loginScreenScrollView.width - 60, height: 52)
        passwordTextField.frame = CGRect(x: 30, y: emailTextField.bottom + 10, width: loginScreenScrollView.width - 60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordTextField.bottom + 10, width: loginScreenScrollView.width - 60, height: 52)
    }
    
    @objc private func loginButtonPressed() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            showAlert()
            return
        }
        
        // Firebase login
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Woops", message: "Please enter all information to log in", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    @objc private func registerButtonPressed() {
        let registerViewController = RegisterViewController()
        registerViewController.title = "Create Account"
        navigationController?.pushViewController(registerViewController, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonPressed()
        }
        
        return true
    }
    
}
