//
//  WelcomeViewController.swift
//  myCar
//
//  Created by Michał on 23/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let titleLabel = UILabel()
        titleLabel.text = "myCar"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        let registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(registerButton)
        
        registerButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.backgroundColor = UIColor.gray
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        
        let loginButton = UIButton()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginButton)
        
        loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.backgroundColor = UIColor.gray
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            let login = UIStoryboard(name: "Main", bundle: nil)
            let vc = login.instantiateViewController(withIdentifier: "CarTableView") as! CarTableViewController
            vc.currentUser = Auth.auth().currentUser?.uid
            self.show(vc, sender: self)
            
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func registerUser() {
        
        let register = UIStoryboard(name: "Register", bundle: nil)
        let vc = register.instantiateViewController(withIdentifier: "RegisterScreen")
        self.show(vc, sender: self)
    }
    
    @objc func login() {
        let login = UIStoryboard(name: "LogIn", bundle: nil)
        let vc = login.instantiateViewController(withIdentifier: "LoginScreen")
        self.show(vc, sender: self)
    }

}