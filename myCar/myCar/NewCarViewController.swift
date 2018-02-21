//
//  ViewController.swift
//  myCar
//
//  Created by Michał on 19/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class NewCarViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properities
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var productionYearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brandTextField.delegate = self
        modelTextField.delegate = self
        productionYearTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    //MARK: Actions
    
    @IBAction func addCar(_ sender: UIButton) {
    }
    
    

}

