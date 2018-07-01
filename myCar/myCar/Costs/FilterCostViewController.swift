//
//  FilterCostViewController.swift
//  myCar
//
//  Created by Michał on 29/06/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class FilterCostViewController: UIViewController, UITextFieldDelegate {
    
    var refCosts: DatabaseReference!
    var currentUser: String?
    var car: Car?
    var costs: Cost?
    
    let filterDateTextField = UITextField()
    let filterDatePickerView = UIDatePicker()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        refCosts = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Costs")
        
        filterDateTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterDateTextField)
        
        filterDateTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        filterDateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        filterDateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        filterDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        filterDatePickerView.datePickerMode = .date
        filterDatePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
        
        filterDateTextField.textAlignment = .left
        filterDateTextField.borderStyle = .roundedRect
        filterDateTextField.placeholder = "Pick year"
        filterDateTextField.inputView = filterDatePickerView
        filterDateTextField.font = UIFont.systemFont(ofSize: 17)
     
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        filterDateTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
}
