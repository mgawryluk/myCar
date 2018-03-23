//
//  CostsTableViewController.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class CostsTableViewController: UITableViewController {

    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CostRepository.instance.getCostsForCar(carIdentifier: car!.identifier).count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CostTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CostTableViewCell else {
            fatalError("Error")
        }
        
        let costs = CostRepository.instance.getCostsForCar(carIdentifier: (car?.identifier)!)[indexPath.row]
        
        cell.costTypeLabel.text = costs.costType
        cell.costDateLabel.text = costs.costDate
        cell.costAmountLabel.text = costs.costAmount
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAddCostSegue" {
            (segue.destination as? AddBillViewController)?.car = car
        }
    }

}
