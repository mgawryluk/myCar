//
//  AddBillViewController.swift
//  myCar
//
//  Created by Michał on 21/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController, UITextFieldDelegate {
    
    var car: Car?

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var billDateTextField: UITextField!
    @IBOutlet weak var billCostTextField: UITextField!
    
    var bills: Bill?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billTextField.delegate = self
        billDateTextField.delegate = self
        billCostTextField.delegate = self
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
    
    @IBAction func addBillButton(_ sender: Any) {
        let billType = billTextField.text
        let billDate = billDateTextField.text
        let billCost = billCostTextField.text
        
        
        guard let bills = Bill(billType: billType, billCost: billCost, billDate: billDate, carIdentifier: car?.identifier)  else {
            
            return
        }
        
        BillRepository.instance.addBills(newBill: bills)
        BillRepository.instance.saveBills()
        
        
        
        navigationController?.popViewController(animated: true)
        
    }
        
    }
    
