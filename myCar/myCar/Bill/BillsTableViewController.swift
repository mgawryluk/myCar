//
//  BillsTableViewController.swift
//  myCar
//
//  Created by Michał on 19/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class BillsTableViewController: UITableViewController, FilterBillViewControllerDelegate {
    func didSelectYear(year: String?) {
        yearPicked = year
    }

    var refBills: DatabaseReference!
    var selectedBill: Bill?
    var currentUser: String?
    var billList = [Bill]()
    var car: Car?
    var yearPicked: String?
    
    override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
        showTitle()
        
        refBills = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Bills")
        
        refBills.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.billList.removeAll()
                for bills in snapshot.children.allObjects as! [DataSnapshot] {
                    let billObject = bills.value as? [String: AnyObject]
                    let billType = billObject?["billType"]
                    let billDate = billObject?["billDate"] as! String?
                    let billCost = billObject?["billCost"]
                    let billID = billObject?["id"]
                    
                    let bill = Bill(billType: billType as! String?, billCost: billCost as! String?, billDate: billDate as! String?, carIdentifier: billID as! String?)
                    
                    let rangeOfYear = billDate?.suffix(4)
                    let yearStr = String(rangeOfYear!)
                    
                    
                    if yearStr == self.yearPicked || self.yearPicked == nil || self.yearPicked == "" {
                    self.billList.append(bill!)
                    }
                }
                self.tableView.reloadData()
            }
            
        })
        

        navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.tableFooterView = UIView()
      

        self.navigationController?.isToolbarHidden = false
        var items =  [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewBill)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        self.toolbarItems = items
        
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
        
        
        ref.child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Bills").observe(.childAdded, with: { (snapshot) in
            
            let billObject = snapshot.value as? [String: AnyObject]
            let billCost = billObject?["billCost"] as! String?
            let billDate = billObject?["billDate"] as! String?
            let rangeOfYear = billDate?.suffix(4)
            let yearStr = String(rangeOfYear!)
            
            if let numericalCost = Double(billCost!) {
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
        let vc = FilterBillViewController()
        (vc as FilterBillViewController).car = car
        (vc as FilterBillViewController).currentUser = currentUser
        self.show(vc, sender: self)
        vc.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return billList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BillsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BillsTableViewCell else {
            fatalError("Error")
        }
        
        let bills = billList[indexPath.row]
        
        cell.billTypeLabel.text = bills.billType
        cell.dateLabel.text = bills.billDate
        cell.costLabel.text = bills.billCost
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeBill = billList[indexPath.row]
            refBills.child(removeBill.carIdentifier).removeValue()
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.billList.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    @objc func addNewBill() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewBill") as! AddBillViewController
        vc.currentUser = currentUser
        vc.car = car
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
