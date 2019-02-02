//
//  AddRepairViewController.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class AddRepairViewController: UIViewController, UITextFieldDelegate {
    
    var refRepairs: DatabaseReference!
    var currentUser: String?
    var car: Car?
    let repairDatePickerView = UIDatePicker()
    var repair: Repair?
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var repairTypeTextField: UITextField!
    @IBOutlet weak var repairDateTextField: UITextField!
    @IBOutlet weak var repairCostTextField: UITextField!
    
    
    var repairs: Repair?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
        repairDateTextField.inputView = datePicker
        
        repairCostTextField.setBottomBorder()
        repairDateTextField.setBottomBorder()
        repairTypeTextField.setBottomBorder()
        
        
        repairTypeTextField.delegate = self
        repairDateTextField.delegate = self
        repairCostTextField.delegate = self
        
        refRepairs = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Repairs")
        
        if repair != nil {
            repairCostTextField.text = repair?.repairCost
            repairDateTextField.text = repair?.repairDate
            repairTypeTextField.text = repair?.repairType
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        repairDateTextField.text = dateFormatter.string(from: datePicker.date)
        
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
    
    
    @IBAction func addRepairButton(_ sender: UIButton) {
        
        if repairTypeTextField.text?.isEmpty ?? true || repairDateTextField.text?.isEmpty ?? true || repairCostTextField.text?.isEmpty ?? true {
            let emptyTextFieldAlert = UIAlertController(title: "Ooops!", message: "It seems you've left some empty fields.", preferredStyle: .alert)
            emptyTextFieldAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(emptyTextFieldAlert, animated: true)
            
        } else {
        
        if self.repair != nil {
        let key = self.repair?.carIdentifier
    
            let repair = ["id": key,
                      "repairType": repairTypeTextField.text! as String,
                      "repairDate": repairDateTextField.text! as String,
                      "repairCost": repairCostTextField.text! as String]
            let childUpdates = ["\(key!)/": repair]
            refRepairs.updateChildValues(childUpdates)
            
        } else {
            let key = refRepairs.childByAutoId().key
            
            let repair = ["id": key,
                          "repairType": repairTypeTextField.text! as String,
                          "repairDate": repairDateTextField.text! as String,
                          "repairCost": repairCostTextField.text! as String]
            refRepairs.child(key).setValue(repair)
        
            }
        }
        
        navigationController?.popViewController(animated: true)
        
        }


    }
