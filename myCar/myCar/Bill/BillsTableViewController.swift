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
        self.tableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAddBillSegue" {
            (segue.destination as? AddBillViewController)?.car = car
        }
    }
}
