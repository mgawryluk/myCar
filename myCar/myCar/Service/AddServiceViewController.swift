//
//  AddServiceViewController.swift
//  myCar
//
//  Created by Michał on 29/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class AddServiceViewController: UIViewController {
    
    var refServices: DatabaseReference!
    var currentUser: String?
    var car: Car?
    var services: Service?
    
    let serviceDateTextField = UITextField()
    let serviceTypeTextField = UITextField()
    let serviceCostTextField = UITextField()
    let serviceDatePickerView = UIDatePicker()
    let addServiceButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        refServices = Database.database().reference().child("Users/\(currentUser!)cars/\((car?.identifier)!)/Services")
    
        
        serviceTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        serviceDateTextField.translatesAutoresizingMaskIntoConstraints = false
        serviceCostTextField.translatesAutoresizingMaskIntoConstraints = false
        addServiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(serviceTypeTextField)
        view.addSubview(serviceDateTextField)
        view.addSubview(serviceCostTextField)
        view.addSubview(addServiceButton)
        
        
        serviceTypeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        serviceTypeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        serviceTypeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        serviceTypeTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        serviceTypeTextField.textAlignment = .left
        serviceTypeTextField.borderStyle = .roundedRect
        serviceTypeTextField.placeholder = "Service type"
        serviceTypeTextField.font = UIFont.systemFont(ofSize: 17)
        
        serviceDateTextField.topAnchor.constraint(equalTo: serviceTypeTextField.bottomAnchor, constant: 20).isActive = true
        serviceDateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        serviceDateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        serviceDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        serviceDatePickerView.datePickerMode = .date
        serviceDatePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
        
        serviceDateTextField.textAlignment = .left
        serviceDateTextField.borderStyle = .roundedRect
        serviceDateTextField.placeholder = "Service date"
        serviceDateTextField.inputView = serviceDatePickerView
        serviceDateTextField.font = UIFont.systemFont(ofSize: 17)
        
        
    
        serviceCostTextField.topAnchor.constraint(equalTo: serviceDateTextField.bottomAnchor, constant: 20).isActive = true
        serviceCostTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        serviceCostTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        serviceCostTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        serviceCostTextField.textAlignment = .left
        serviceCostTextField.borderStyle = .roundedRect
        serviceCostTextField.placeholder = "Service cost"
        serviceCostTextField.font = UIFont.systemFont(ofSize: 17)
        self.serviceCostTextField.keyboardType = .decimalPad
        
        
        
        addServiceButton.topAnchor.constraint(equalTo: serviceCostTextField.bottomAnchor, constant: 30).isActive = true
        addServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        addServiceButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        addServiceButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addServiceButton.backgroundColor = UIColor.gray
        addServiceButton.setTitle("Add service", for: .normal)
        addServiceButton.addTarget(self, action: #selector(addService), for: .touchUpInside)
        
        
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
        
        serviceDateTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    
    @objc func addService(sender: UIButton!) {
        let key = refServices.childByAutoId().key
        
        let service = ["id": key,
                       "serviceType": serviceTypeTextField.text! as String,
                       "serviceDate": serviceDateTextField.text! as String,
                       "serviceCost": serviceCostTextField.text! as String]
        
        refServices.child(key).setValue(service)
        
//        let serviceType = serviceTypeTextField.text
//        let serviceDate = serviceDateTextField.text
//        let serviceCost = serviceCostTextField.text
//
//        guard let services = Service(serviceType: serviceType, serviceCost: serviceCost, serviceDate: serviceDate, carIdentifier: car?.identifier)  else {
//
//            return
//        }
//
//        ServiceRepository.instance.addService(newService: services)
//        ServiceRepository.instance.saveService()
        
        navigationController?.popViewController(animated: true)
        
    }
}
