//
//  ViewController.swift
//  Messenger
//
//  Created by José Pinto on 2020-07-08.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleRedirection()
    }
    
    private func handleRedirection() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false)
        }
    }
    
}

