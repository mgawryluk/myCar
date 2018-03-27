//
//  ViewController.swift
//  myCar
//
//  Created by Michał on 19/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class NewCarViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properities
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var productionYearTextField: UITextField!
    
    @IBOutlet weak var addCarButton: UIButton!
    
    var car: Car?
    
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
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
    }
    
    //MARK: Actions
    
    @IBAction func addCar(_ sender: UIButton) {
        let brand = brandTextField.text
        let model = modelTextField.text
        let productionYear = productionYearTextField.text
        
        guard let car = Car(brand: brand, model: model, productionYear: productionYear)  else {
            
            return
        }
        
        CarRepository.instance.addNewCar(car: car)
        CarRepository.instance.saveCars()
        
        navigationController?.popViewController(animated: true)
    
    }
    
    

}

