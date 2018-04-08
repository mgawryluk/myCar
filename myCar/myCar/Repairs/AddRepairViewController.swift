//
//  AddRepairViewController.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class AddRepairViewController: UIViewController, UITextFieldDelegate {
    
    var car: Car?
    
    @IBOutlet weak var repairTypeTextField: UITextField!
    @IBOutlet weak var repairDateTextField: UITextField!
    @IBOutlet weak var repairCostTextField: UITextField!
    
    var costs: Cost?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repairTypeTextField.delegate = self
        repairDateTextField.delegate = self
        repairCostTextField.delegate = self
        
        
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
    
    
    @IBAction func addRepairButton(_ sender: UIButton) {
        
        let repairType = repairTypeTextField.text
        let repairDate = repairDateTextField.text
        let repairCost = repairCostTextField.text
        
        
        guard let repairs = Repair(repairType: repairType, repairCost: repairCost, repairDate: repairDate, carIdentifier: car?.identifier)  else {
            
            return
    }
    
        RepairRepository.instance.addRepairs(newRepair: repairs)
        RepairRepository.instance.saveRepairs()
        
        
        
        navigationController?.popViewController(animated: true)
        
    }

}
