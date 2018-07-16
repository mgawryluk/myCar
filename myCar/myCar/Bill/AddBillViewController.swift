//
//  AddBillViewController.swift
//  myCar
//
//  Created by Michał on 21/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class AddBillViewController: UIViewController, UITextFieldDelegate {
    
    var refBills: DatabaseReference!
    var currentUser: String?
    var car: Car?

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var billDateTextField: UITextField!
    @IBOutlet weak var billCostTextField: UITextField!
    
    var bills: Bill?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
        billDateTextField.inputView = datePicker
        
        billTextField.delegate = self
        billDateTextField.delegate = self
        billCostTextField.delegate = self
        
        refBills = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Bills")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
        
        @objc func datePickerValueChanged(datePicker: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            billDateTextField.text = dateFormatter.string(from: datePicker.date)
            
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
    
    @IBAction func addBillButton(_ sender: Any) {
        let key = refBills.childByAutoId().key
        
        let bill = ["id": key,
                    "billType": billTextField.text! as String,
                    "billDate": billDateTextField.text! as String,
                    "billCost": billCostTextField.text! as String]
        
        refBills.child(key).setValue(bill)
        
    
        navigationController?.popViewController(animated: true)
        
    }
        
    }
    
