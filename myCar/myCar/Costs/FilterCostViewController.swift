//
//  FilterCostViewController.swift
//  myCar
//
//  Created by Michał on 29/06/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class FilterCostViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var refCosts: DatabaseReference!
    var currentUser: String?
    var car: Car?
    var costs: Cost?
    let pickerData = ["2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018"]
    
    let filterDateTextField = UITextField()
   // let filterDatePickerView = UIDatePicker()
    let filterDateView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        filterDateView.dataSource = self
        filterDateView.delegate = self
        
        refCosts = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Costs")
        
        filterDateTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterDateTextField)
        
        filterDateTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        filterDateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        filterDateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        filterDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        filterDatePickerView.datePickerMode = .date
//        filterDatePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
        
        filterDateTextField.textAlignment = .left
        filterDateTextField.borderStyle = .roundedRect
        filterDateTextField.placeholder = "Pick year"
        filterDateTextField.inputView = filterDateView
        filterDateTextField.font = UIFont.systemFont(ofSize: 17)
     
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.filterDateTextField.text = pickerData[row]
        self.view.endEditing(true)

    
    
//    @objc func datePickerValueChanged(datePicker: UIPickerView) {
//
//        var yearPicker : [String] {
//            var years = [String]()
//            for i in (2000..<2018).reversed() {
//                years.append("\(i)")
//            }
//            return years
//        }
//    }
    }
}
