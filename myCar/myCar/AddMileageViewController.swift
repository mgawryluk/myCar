//
//  AddMileageViewController.swift
//  myCar
//
//  Created by Michał on 09/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class AddMileageViewController: UIViewController, UITextFieldDelegate {
    
    var car: Car?

    
    @IBOutlet weak var mileageYearTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    
    var km: Mileage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mileageYearTextField.delegate = self
        distanceTextField.delegate = self
        
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
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       super.prepare(for: segue, sender: sender)
    }
    
    
    //MARK: Actions
    
    @IBAction func addDistanceButton(_ sender: UIButton) {
        let mileageYear = mileageYearTextField.text
        let distance = distanceTextField.text
        
        
        guard let km = Mileage(mileageYear: mileageYear, distance: distance, carIdentifier: car?.identifier)  else {
            
            return
        }
        
        MileageRepository.instance.addMileage(km: km)
        MileageRepository.instance.saveMileage()
        
 
        
        navigationController?.popViewController(animated: true)
        
    }
}

