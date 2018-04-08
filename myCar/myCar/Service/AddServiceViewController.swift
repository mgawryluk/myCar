//
//  AddServiceViewController.swift
//  myCar
//
//  Created by Michał on 29/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class AddServiceViewController: UIViewController {
    
    let dateTypeTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let serviceTypeTextField = UITextField()
        serviceTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(serviceTypeTextField)
        
        serviceTypeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        serviceTypeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        serviceTypeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        serviceTypeTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        serviceTypeTextField.textAlignment = .left
        serviceTypeTextField.borderStyle = .roundedRect
        serviceTypeTextField.placeholder = "Service type"
        serviceTypeTextField.font = UIFont.systemFont(ofSize: 17)
        
        
        dateTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dateTypeTextField)
        
        dateTypeTextField.topAnchor.constraint(equalTo: serviceTypeTextField.bottomAnchor, constant: 20).isActive = true
        dateTypeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        dateTypeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        dateTypeTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let serviceDatePickerView = UIDatePicker()
        serviceDatePickerView.datePickerMode = .date
        serviceDatePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
        
        dateTypeTextField.textAlignment = .left
        dateTypeTextField.borderStyle = .roundedRect
        dateTypeTextField.placeholder = "Service date"
        dateTypeTextField.inputView = serviceDatePickerView
        dateTypeTextField.font = UIFont.systemFont(ofSize: 17)
        
        let serviceCostTextField = UITextField()
        serviceCostTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(serviceCostTextField)
        
        serviceCostTextField.topAnchor.constraint(equalTo: dateTypeTextField.bottomAnchor, constant: 20).isActive = true
        serviceCostTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        serviceCostTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        serviceCostTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        serviceCostTextField.textAlignment = .right
        serviceCostTextField.borderStyle = .roundedRect
        serviceCostTextField.placeholder = "Service cost"
        serviceCostTextField.font = UIFont.systemFont(ofSize: 17)
        
    
        
        
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
        
        dateTypeTextField.text = dateFormatter.string(from: datePicker.date)
        
    }

}
