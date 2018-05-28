//
//  LogInViewController.swift
//  myCar
//
//  Created by Michał on 23/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        
        emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        emailTextField.textAlignment = .left
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Enter email"
        emailTextField.font = UIFont.systemFont(ofSize: 17)
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        passwordTextField.textAlignment = .left
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Enter password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        loginButton.backgroundColor = UIColor.gray
        loginButton.setTitle("Log in", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.autocapitalizationType = .none

        }
    
    @objc func login() {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                let userID: String = user!.uid
                SVProgressHUD.dismiss()
                let login = UIStoryboard(name: "Main", bundle: nil)
                let vc = login.instantiateViewController(withIdentifier: "CarTableView") as! CarTableViewController
                vc.currentUser = userID
                self.show(vc, sender: self)
            }
            
        } 
        
        
     }
    
}