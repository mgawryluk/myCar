//
//  FilterMileageViewController.swift
//  myCar
//
//  Created by Michał on 12/07/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase
protocol FilterMileageViewControllerDelegate: class {
    func didSelectYear(year: String?)
}

class FilterMileageViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var delegate: FilterMileageViewControllerDelegate?
    
    var refMileage: DatabaseReference!
    var currentUser: String?
    var car: Car?
    var mileage: Mileage?
    var pickerData = [String]()
    let filterYearButton = UIButton()
    
    let filterDateTextField = UITextField()
    let filterDateView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        filterDateView.dataSource = self
        filterDateView.delegate = self
        
        refMileage = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Mileage")
        
        
        filterDateTextField.translatesAutoresizingMaskIntoConstraints = false
        filterYearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterYearButton)
        view.addSubview(filterDateTextField)
        
        filterDateTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        filterDateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        filterDateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        filterDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        filterDateTextField.textAlignment = .left
        filterDateTextField.borderStyle = .roundedRect
        filterDateTextField.placeholder = "Pick year"
        filterDateTextField.inputView = filterDateView
        filterDateTextField.font = UIFont.systemFont(ofSize: 17)
        
        filterDateView.dataSource?.perform(#selector(showYear))
        
        
        
        filterYearButton.topAnchor.constraint(equalTo: filterDateTextField.bottomAnchor, constant: 30).isActive = true
        filterYearButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        filterYearButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        filterYearButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        filterYearButton.backgroundColor = UIColor.gray
        filterYearButton.setTitle("Select", for: .normal)
        filterYearButton.addTarget(self, action: #selector(filterYear), for: .touchUpInside)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showYear() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        self.pickerData.append("")
        
        ref.child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Mileage").observe(.childAdded, with: { (snapshot) in
            
            let mileageObject = snapshot.value as? [String: AnyObject]
            let mileageYear = mileageObject?["mileageYear"] as! String?
            let yearStr = String(mileageYear!)
            
            if !self.pickerData.contains(yearStr) {
                self.pickerData.append(yearStr)
            }
        })
        
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
        
    }
    
    @objc func filterYear(sender: UIButton!) {
        
        delegate?.didSelectYear(year: filterDateTextField.text)
        navigationController?.popViewController(animated: true)
        
    }

}
