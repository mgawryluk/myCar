//
//  AddMileageViewController.swift
//  myCar
//
//  Created by Michał on 09/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class AddMileageViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var mileageYearTextField: UITextField!
    @IBOutlet weak var distanceTextLabel: UITextField!
    
    var km: Mileage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mileageYearTextField.delegate = self
        distanceTextLabel.delegate = self
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    
    @IBAction func addDistanceButton(_ sender: UIButton) {
        let mileageYear = mileageYearTextField.text
        let distance = distanceTextLabel.text
        
        guard let km = Mileage(mileageYear: mileageYear, distance: distance)  else {
            
            return
        }
        
        MileageRepository.instance.addMileage(km: km)
        MileageRepository.instance.saveMileage()
        
        dismiss(animated: true, completion: nil)
        
    }
}

