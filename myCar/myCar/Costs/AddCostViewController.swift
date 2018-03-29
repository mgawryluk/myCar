//
//  AddCostViewController.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class AddCostViewController: UIViewController, UITextFieldDelegate {
    
    var car: Car?

    @IBOutlet weak var costTypeTextField: UITextField!
    @IBOutlet weak var costDateTextField: UITextField!
    @IBOutlet weak var costAmountTextField: UITextField!
    
    var costs: Cost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        costTypeTextField.delegate = self
        costDateTextField.delegate = self
        costAmountTextField.delegate = self

        
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
    
    @IBAction func addCostButton(_ sender: UIButton) {
        
        let costType = costTypeTextField.text
        let costDate = costDateTextField.text
        let costAmount = costAmountTextField.text
        
        
        guard let costs = Cost(costType: costType, costAmount: costAmount, costDate: costDate, carIdentifier: car?.identifier)  else {
            
            return
        }
        
        CostRepository.instance.addCosts(newCost: costs)
        CostRepository.instance.saveCosts()
        
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
