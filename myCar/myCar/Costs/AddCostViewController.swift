//
//  AddCostViewController.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class AddCostViewController: UIViewController, UITextFieldDelegate {
    
    var refCosts: DatabaseReference!
    var currentUser: String?
    var car: Car?

    @IBOutlet weak var costTypeTextField: UITextField!
    @IBOutlet weak var costDateTextField: UITextField!
    @IBOutlet weak var costAmountTextField: UITextField!
    
    var costs: Cost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: UIControlEvents.valueChanged)
        
        costDateTextField.inputView = datePicker
        
        costTypeTextField.delegate = self
        costDateTextField.delegate = self
        costAmountTextField.delegate = self
        
        refCosts = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Costs")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        costDateTextField.text = dateFormatter.string(from: datePicker.date)
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
    
    @IBAction func addCostButton(_ sender: UIButton) {
        let key = refCosts.childByAutoId().key
        
        let cost = ["id": key,
                    "costType": costTypeTextField.text! as String,
                    "costDate": costDateTextField.text! as String,
                    "costAmount": costAmountTextField.text! as String]
        
        refCosts.child(key).setValue(cost)
        navigationController?.popViewController(animated: true)
        
        
//        let costType = costTypeTextField.text
//        let costDate = costDateTextField.text
//        let costAmount = costAmountTextField.text
//
//
//        guard let costs = Cost(costType: costType, costAmount: costAmount, costDate: costDate, carIdentifier: car?.identifier)  else {
//
//            return
//        }
//
//        CostRepository.instance.addCosts(newCost: costs)
//        CostRepository.instance.saveCosts()
//
//
//
//        navigationController?.popViewController(animated: true)
//
    }
    
}
