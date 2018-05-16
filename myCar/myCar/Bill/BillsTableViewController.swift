//
//  BillsTableViewController.swift
//  myCar
//
//  Created by Michał on 19/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class BillsTableViewController: UITableViewController {

    var refBills: DatabaseReference!
    var selectedBill: Bill?
    var currentUser: String?
    var billList = [Bill]()
    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refBills = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Bills")
        
        refBills.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.billList.removeAll()
                for bills in snapshot.children.allObjects as! [DataSnapshot] {
                    let billObject = bills.value as? [String: AnyObject]
                    let billType = billObject?["billType"]
                    let billDate = billObject?["billDate"]
                    let billCost = billObject?["billCost"]
                    let billID = billObject?["id"]
                    
                    let bill = Bill(billType: billType as! String?, billCost: billCost as! String?, billDate: billDate as! String?, carIdentifier: billID as! String?)
                    
                    self.billList.append(bill!)
                    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
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
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    @objc func addNewBill() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewBill") as! AddBillViewController
        vc.currentUser = currentUser
        vc.car = car
        self.show(vc!, sender: self)
      
    }

}
