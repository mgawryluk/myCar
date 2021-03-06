//
//  AddInsuranceViewController.swift
//  myCar
//
//  Created by Michał on 29/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class AddInsuranceViewController: UIViewController, UITextFieldDelegate {
    
    var refInsurances: DatabaseReference!
    var currentUser: String?
    var car: Car?
    var insurance: Insurance?
    
    let insuranceDateTextField = UITextField()
    let insuranceTypeTextField = UITextField()
    let insuranceCostTextField = UITextField()
    let insuranceDatePickerView = UIDatePicker()
    let addInsuranceButton = UIButton(type: .custom)
    let background = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        refInsurances = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Insurances")
    
        
        insuranceTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        insuranceDateTextField.translatesAutoresizingMaskIntoConstraints = false
        insuranceCostTextField.translatesAutoresizingMaskIntoConstraints = false
        addInsuranceButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(insuranceTypeTextField)
        view.addSubview(insuranceDateTextField)
        view.addSubview(insuranceCostTextField)
        view.addSubview(addInsuranceButton)
        
        
        insuranceTypeTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        insuranceTypeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        insuranceTypeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        insuranceTypeTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        insuranceTypeTextField.textAlignment = .left
        insuranceTypeTextField.borderStyle = .roundedRect
        insuranceTypeTextField.placeholder = "Insurance type"
        insuranceTypeTextField.font = UIFont.systemFont(ofSize: 17)
        insuranceTypeTextField.setBottomBorder()
        
        insuranceDateTextField.topAnchor.constraint(equalTo: insuranceTypeTextField.bottomAnchor, constant: 20).isActive = true
        insuranceDateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        insuranceDateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        insuranceDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        insuranceDatePickerView.datePickerMode = .date
        insuranceDatePickerView.backgroundColor = UIColor.white
        insuranceDatePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
        
        insuranceDateTextField.textAlignment = .left
        insuranceDateTextField.borderStyle = .roundedRect
        insuranceDateTextField.placeholder = "Insurance date"
        insuranceDateTextField.inputView = insuranceDatePickerView
        insuranceDateTextField.font = UIFont.systemFont(ofSize: 17)
        insuranceDateTextField.setBottomBorder()
        
        
    
        insuranceCostTextField.topAnchor.constraint(equalTo: insuranceDateTextField.bottomAnchor, constant: 20).isActive = true
        insuranceCostTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        insuranceCostTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        insuranceCostTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        insuranceCostTextField.textAlignment = .left
        insuranceCostTextField.borderStyle = .roundedRect
        insuranceCostTextField.placeholder = "Insurance cost"
        insuranceCostTextField.font = UIFont.systemFont(ofSize: 17)
        insuranceCostTextField.setBottomBorder()
        self.insuranceCostTextField.keyboardType = .decimalPad
        
        
        
        addInsuranceButton.topAnchor.constraint(equalTo: insuranceCostTextField.bottomAnchor, constant: 25).isActive = true
        addInsuranceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 112.39).isActive = true
        addInsuranceButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -112.61).isActive = true
        addInsuranceButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addInsuranceButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addInsuranceButton.backgroundColor = UIColor.lightGray
        addInsuranceButton.setImage(UIImage(named:"addButton"), for: .normal)
        addInsuranceButton.addTarget(self, action: #selector(addInsurance), for: .touchUpInside)
        
        if insurance != nil {
            insuranceCostTextField.text = insurance?.insuranceCost
            insuranceDateTextField.text = insurance?.insuranceDate
            insuranceTypeTextField.text = insurance?.insuranceType

        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        insuranceDateTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    
    @objc func addInsurance(sender: UIButton!) {
        
        if insuranceTypeTextField.text?.isEmpty ?? true || insuranceDateTextField.text?.isEmpty ?? true || insuranceCostTextField.text?.isEmpty ?? true {
            let emptyTextFieldAlert = UIAlertController(title: "Ooops!", message: "It seems you've left some empty fields.", preferredStyle: .alert)
            emptyTextFieldAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(emptyTextFieldAlert, animated: true)
            
        } else {
        
        if self.insurance != nil {
            let key = self.insurance?.carIdentifier
            
            let insurance = ["id": key!,
                           "insuranceType": insuranceTypeTextField.text! as String,
                           "insuranceDate": insuranceDateTextField.text! as String,
                           "insuranceCost": insuranceCostTextField.text! as String]
            let childUpdates = ["\(key!)/": insurance]
            refInsurances.updateChildValues(childUpdates)
        } else {
            let key = refInsurances.childByAutoId().key
            
            let insurance = ["id": key,
                           "insuranceType": insuranceTypeTextField.text! as String,
                           "insuranceDate": insuranceDateTextField.text! as String,
                           "insuranceCost": insuranceCostTextField.text! as String]
        refInsurances.child(key).setValue(insurance)
        
            }
            
        }
        
        navigationController?.popViewController(animated: true)
    }
}
