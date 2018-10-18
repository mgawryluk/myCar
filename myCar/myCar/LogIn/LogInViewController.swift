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
    let newPasswordButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        newPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(newPasswordButton)
        
        
        emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        emailTextField.textAlignment = .left
        emailTextField.borderStyle = .roundedRect
//        emailTextField.placeholder = "Enter email"
        emailTextField.font = UIFont.systemFont(ofSize: 17)
        emailTextField.autocapitalizationType = .none
        emailTextField.setIcon(name: "email2")
        emailTextField.tintColor = UIColor.lightGray
        emailTextField.setBottomBorder()
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        passwordTextField.textAlignment = .left
        passwordTextField.borderStyle = .roundedRect
//         passwordTextField.placeholder = "Enter password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setIcon(name: "password")
        passwordTextField.tintColor = UIColor.lightGray
        passwordTextField.setBottomBorder()
        
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        loginButton.backgroundColor = UIColor.gray
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        newPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        newPasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 180).isActive = true
        newPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        newPasswordButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        newPasswordButton.backgroundColor = UIColor.white
        newPasswordButton.setTitle("Forgot password?", for: .normal)
        newPasswordButton.setTitleColor(UIColor.lightGray, for: .normal)
        newPasswordButton.addTarget(self, action: #selector(newPassword), for: .touchUpInside)
        newPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        newPasswordButton.titleLabel?.font = UIFont(name: "System", size: 9)
        
        

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
    
    @objc func newPassword() {
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
            forgotPasswordAlert.addTextField { (textField) in textField.placeholder = "Enter email address" }
        
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else {
                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }))
        
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
    
}
