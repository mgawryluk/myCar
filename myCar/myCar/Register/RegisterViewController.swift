//
//  RegisterViewController.swift
//  myCar
//
//  Created by Michał on 23/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

  
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameTextField.textAlignment = .left
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Enter name"
        nameTextField.font = UIFont.systemFont(ofSize: 17)
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
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
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        passwordTextField.isSecureTextEntry = true
        
        
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        registerButton.backgroundColor = UIColor.gray
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func registerUser() {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error != nil {
                    print(error!)
                } else {
                    SVProgressHUD.dismiss()
                    let register = UIStoryboard(name: "Main", bundle: nil)
                    let vc = register.instantiateViewController(withIdentifier: "CarTableView")
                    self.show(vc, sender: self)
            }
            
        } )
    

}
}
