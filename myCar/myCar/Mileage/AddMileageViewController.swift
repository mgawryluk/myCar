//
//  AddMileageViewController.swift
//  myCar
//
//  Created by Michał on 09/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class AddMileageViewController: UIViewController, UITextFieldDelegate {
    
    var refMileage: DatabaseReference!
    var currentUser: String?
    var car: Car?
    var mileage: Mileage?

    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mileageYearTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    
    var km: Mileage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mileageYearTextField.delegate = self
        distanceTextField.delegate = self
        
        refMileage = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Mileage")
        
        if mileage != nil {
            mileageYearTextField.text = mileage?.mileageYear
            distanceTextField.text = mileage?.distance
            editButton.setTitle("Edit", for: .normal)
        }
        
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
        
        if self.mileage != nil {
            let key = self.mileage?.carIdentifier
            let mileage = ["id": key,
                           "mileageYear": mileageYearTextField.text! as String,
                           "distance": distanceTextField.text! as String]
            let childUpdates = ["\(key!)/": mileage]
            refMileage.updateChildValues(childUpdates)
        } else {
        let key = refMileage.childByAutoId().key
        let mileage = ["id": key,
                       "mileageYear": mileageYearTextField.text! as String,
                       "distance": distanceTextField.text! as String]
        
        refMileage.child(key).setValue(mileage)
        

        }
        navigationController?.popViewController(animated: true)
        
    
        
    }
}

