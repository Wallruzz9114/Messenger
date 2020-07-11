//
//  RegisterViewController.swift
//  Messenger
//
//  Created by José Pinto on 2020-07-08.
//

import UIKit

class RegisterViewController: UIViewController {

    private let registerScreenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
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
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "First Name"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.backgroundColor = .white
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Last Name"
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Register"
        view.backgroundColor = .white
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        emailTextField.delegate = self
        passwordTextField.delegate  = self
        
        // Add subviews
        view.addSubview(registerScreenScrollView)
        registerScreenScrollView.addSubview(logoImageView)
        registerScreenScrollView.addSubview(firstNameTextField)
        registerScreenScrollView.addSubview(lastNameTextField)
        registerScreenScrollView.addSubview(emailTextField)
        registerScreenScrollView.addSubview(passwordTextField)
        registerScreenScrollView.addSubview(registerButton)
        registerScreenScrollView.isUserInteractionEnabled = true
        logoImageView.isUserInteractionEnabled = true
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageGestureRecognizer.numberOfTouchesRequired = 1
        
        logoImageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set frame
        registerScreenScrollView.frame = view.bounds
        let size = registerScreenScrollView.width / 3
        logoImageView.frame = CGRect(x: (registerScreenScrollView.width - size) / 2, y: 20, width: size, height: size)
        firstNameTextField.frame = CGRect(x: 30, y: logoImageView.bottom + 10, width: registerScreenScrollView.width - 60, height: 52)
        lastNameTextField.frame = CGRect(x: 30, y: firstNameTextField.bottom + 10, width: registerScreenScrollView.width - 60, height: 52)
        emailTextField.frame = CGRect(x: 30, y: lastNameTextField.bottom + 10, width: registerScreenScrollView.width - 60, height: 52)
        passwordTextField.frame = CGRect(x: 30, y: emailTextField.bottom + 10, width: registerScreenScrollView.width - 60, height: 52)
        registerButton.frame = CGRect(x: 30, y: passwordTextField.bottom + 10, width: registerScreenScrollView.width - 60, height: 52)
    }
    
    @objc private func registerButtonPressed() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            showAlert()
            return
        }
        
        // Firebase register
    }
    
    @objc private func imageViewTapped() {
        
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Woops", message: "Please enter all information to register", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }

}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            registerButtonPressed()
        }
        
        return true
    }
    
}
