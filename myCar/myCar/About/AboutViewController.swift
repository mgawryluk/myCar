//
//  AboutViewController.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class AboutViewController: UIViewController {
    
    let logoutButton = UIButton()
    let infoLabel = UILabel()
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        showTitle()

        
        titleLabel.text = "myCar 1.0"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        
        infoLabel.text = "I really hope you like it. It's my first app and I'll do my best to improve it over time. \nIf you have any suggestions, drop me a message at mg@michalgawryluk.com or catch me up on Twitter at @michalgawryluk."
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        logoutButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 25).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 112.39).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -112.61).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoutButton.backgroundColor = UIColor.lightGray
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        
        
        
    
        
        
    }
    
    func showTitle() {
        let title = UILabel()
        title.text = "About"
        self.navigationItem.titleView = title
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func logoutUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }

}
