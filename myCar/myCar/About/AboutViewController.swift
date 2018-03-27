//
//  AboutViewController.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel()
        titleLabel.text = "myCar"
     // titleLabel.frame = CGRect(x: 50, y: 50, width: 100, height: 40)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        let infoLabel = UILabel()
        infoLabel.text = "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        infoLabel.numberOfLines = 0
        
        
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

}
