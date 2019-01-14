//
//  InsuranceTableViewController.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class InsuranceTableViewController: UITableViewController, FilterInsuranceViewControllerDelegate {
    func didSelectYear(year: String?) {
        yearPicked = year
    }
    
    var refInsurances: DatabaseReference!
    var selectedInsurance: Insurance?
    var currentUser: String?
    var car: Car?
    var insuranceList = [Insurance]()
    var yearPicked: String?


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showTitle()
        
        refInsurances = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Insurances")
        
        refInsurances.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.insuranceList.removeAll()
                for insurances in snapshot.children.allObjects as! [DataSnapshot] {
                    let insuranceObject = insurances.value as? [String: AnyObject]
                    let insuranceType = insuranceObject?["insuranceType"]
                    let insuranceDate = insuranceObject?["insuranceDate"] as! String?
                    let insuranceCost = insuranceObject?["insuranceCost"]
                    let insuranceID = insuranceObject?["id"]
                    
                    let insurance = Insurance(insuranceType: insuranceType as! String?, insuranceCost: insuranceCost as! String?, insuranceDate: insuranceDate as! String?, carIdentifier: insuranceID as! String?)
                    
                    
                    let rangeOfYear = insuranceDate?.suffix(4)
                    let yearStr = String(rangeOfYear!)
                    
                    if yearStr == self.yearPicked || self.yearPicked == nil || self.yearPicked == "" {
                    self.insuranceList.append(insurance!)
                    
                    }
                }
                self.tableView.reloadData()
            }
            
        })
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 100
        
        navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.tableFooterView = UIView()
        
        self.navigationController?.isToolbarHidden = false
        var items =  [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addInsurance)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        self.toolbarItems = items
        
        tableView.register(InsuranceTableViewCell.self, forCellReuseIdentifier: "InsuranceTableViewCell")
        
      

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tableView.reloadData()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        var sum = 0.0
        title.text = "\(sum)"
        self.navigationItem.titleView = title
        title.widthAnchor.constraint(equalToConstant: 100).isActive = true
        title.textAlignment = .center
        self.setTitleWithValue(value: sum, title: title)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        ref.child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Insurances").observe(.childAdded, with: { (snapshot) in
            
            let insuranceObject = snapshot.value as? [String: AnyObject]
            let insuranceCost = insuranceObject?["insuranceCost"] as! String?
            let insuranceDate = insuranceObject?["insuranceDate"] as! String?
            let rangeOfYear = insuranceDate?.suffix(4)
            let yearStr = String(rangeOfYear!)
            
            if let numericalCost = Double(insuranceCost!) {
                if yearStr == self.yearPicked || self.yearPicked == nil || self.yearPicked == "" {
                    sum += numericalCost
                }
                print(numericalCost)
                
            }
            
            self.setTitleWithValue(value: sum, title: title)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.addTarget(self, action: #selector(filterData))
        
        title.isUserInteractionEnabled = true
        title.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func filterData() {
        let vc = FilterInsuranceViewController()
        (vc as FilterInsuranceViewController).car = car
        (vc as FilterInsuranceViewController).currentUser = currentUser
        self.show(vc, sender: self)
        vc.delegate = self
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return insuranceList.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "InsuranceTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InsuranceTableViewCell else {
            fatalError("Error")
        }
        
        let insurances = insuranceList[indexPath.row]
        
        cell.insuranceTypeLabel.text = insurances.insuranceType
        cell.insuranceDateLabel.text = insurances.insuranceDate
        cell.insuranceCostLabel.text = insurances.insuranceCost
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let insurance = insuranceList[indexPath.row]
        
        let vc = AddInsuranceViewController()
        (vc as AddInsuranceViewController).car = car
        (vc as AddInsuranceViewController).currentUser = currentUser
        (vc as AddInsuranceViewController).insurance = insurance
        self.show(vc, sender: self)
        
        
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeInsurance = insuranceList[indexPath.row]
            refInsurances.child(removeInsurance.carIdentifier).removeValue()
            self.insuranceList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            
        } else if editingStyle == .insert {
    
//            let key = refInsurances.childByAutoId().key
//            let insurance = ["id": key,
//                           "insuranceType": insuranceType,
//                           "insuranceCost": insuranceCost,
//                           "insuranceDate": insuranceDate]
//            let childUpdates = ["/Insurances/\(key)/": insurance]
//            refInsurances.updateChildValues(childUpdates)
        
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func addInsurance() {
        
        let vc = AddInsuranceViewController()
        (vc as AddInsuranceViewController).car = car
        (vc as AddInsuranceViewController).currentUser = currentUser
        self.show(vc, sender: self)
        
        }
    
    func setTitleWithValue(value: Double, title: UILabel) {
        if yearPicked == nil || yearPicked == "" {
            title.text = "\(value)"
            title.addImageWith(name: "filter_off", behindText: true)
        } else {
            title.text = "\(value)"
            title.addImageWith(name: "filter_on", behindText: true)
        }
    }
    
}
