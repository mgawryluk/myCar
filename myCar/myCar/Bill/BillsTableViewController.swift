//
//  BillsTableViewController.swift
//  myCar
//
//  Created by Michał on 19/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class BillsTableViewController: UITableViewController {

    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        return BillRepository.instance.getBillsForCar(carIdentifier: car!.identifier).count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BillsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BillsTableViewCell else {
            fatalError("Error")
        }
        
        let bills = BillRepository.instance.getBillsForCar(carIdentifier: (car?.identifier)!)[indexPath.row]
        
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
            // Delete the row from the data source
            
            BillRepository.instance.deleteBill(indexPath: indexPath.row)
            BillRepository.instance.saveBills()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    @objc func addNewBill() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewBill")
        (vc as? AddBillViewController)?.car = car
        self.show(vc!, sender: self)
      
    }

}
