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

    var ref: DatabaseReference!
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "login_background.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameTextField.textAlignment = .left
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Enter name"
        nameTextField.font = UIFont.systemFont(ofSize: 17)
        nameTextField.tintColor = UIColor.darkGray
        nameTextField.setBottomBorder()
        nameTextField.alpha = 0.5
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        emailTextField.textAlignment = .left
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Enter email"
        emailTextField.font = UIFont.systemFont(ofSize: 17)
        emailTextField.tintColor = UIColor.darkGray
        emailTextField.setBottomBorder()
        emailTextField.alpha = 0.5
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        passwordTextField.textAlignment = .left
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tintColor = UIColor.darkGray
        passwordTextField.setBottomBorder()
        passwordTextField.alpha = 0.5
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        
        
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        registerButton.backgroundColor = UIColor.clear
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        emailTextField.autocapitalizationType = .none
        nameTextField.autocapitalizationType = .none
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func registerUser() {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error != nil {
                    let nsError = error as NSError?
                    if nsError?.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                        let alert = UIAlertController(title: "Ooops!", message: "It looks like this e-mail already exists in our database.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        SVProgressHUD.dismiss()
                    } else if nsError?.code == AuthErrorCode.weakPassword.rawValue {
                        let alert = UIAlertController(title: "Ooops!", message: "It looks like your password is too short. Make it at least 6 characters long.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        SVProgressHUD.dismiss()
                        
                    } else {
                        print ("Email ok!")
                    }
                    
                } else {
                    let userID: String = user!.uid
                    let userEmail: String = self.emailTextField.text!
                    let userPassword: String = self.passwordTextField.text!
                    self.ref.child("Users").child(userID).setValue(["Email": userEmail, "Password": userPassword])
                    
                    SVProgressHUD.dismiss()
                    let register = UIStoryboard(name: "Main", bundle: nil)
                    let vc = register.instantiateViewController(withIdentifier: "CarTableView") as! CarTableViewController
                    vc.currentUser = userID
                    self.show(vc, sender: self)
            }
            
            
            
        } )
        
    }
}
