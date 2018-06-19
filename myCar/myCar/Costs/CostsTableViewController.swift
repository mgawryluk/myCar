//
//  CostsTableViewController.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class CostsTableViewController: UITableViewController {

    var refCosts: DatabaseReference!
    var selectedCost: Cost?
    var currentUser: String?
    var car: Car?
    var costList = [Cost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTitle()
        
        refCosts = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Costs")
        
        refCosts.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.costList.removeAll()
                for costs in snapshot.children.allObjects as! [DataSnapshot] {
                    let costObject = costs.value as? [String: AnyObject]
                    let costType = costObject?["costType"]
                    let costDate = costObject?["costDate"]
                    let costAmount = costObject?["costAmount"]
                    let costID = costObject?["id"]
                    
                    let cost = Cost(costType: costType as! String?, costAmount: costAmount as! String?, costDate: costDate as! String?, carIdentifier: costID as! String?)
                    
                    self.costList.append(cost!)
                    
                }
                self.tableView.reloadData()
            }
            
        })
        
        navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.tableFooterView = UIView()
        
        
        self.navigationController?.isToolbarHidden = false
        var items =  [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCost)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        self.toolbarItems = items
    }
    
    func showTitle() {
        let title = UILabel()
        title.text = "Costs"
        self.navigationItem.titleView = title
        
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
        
        return costList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CostTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CostTableViewCell else {
            fatalError("Error")
        }
        
        let costs = costList[indexPath.row]
        
        cell.costTypeLabel.text = costs.costType
        cell.costDateLabel.text = costs.costDate
        cell.costAmountLabel.text = costs.costAmount
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeCost = costList[indexPath.row]
            refCosts.child(removeCost.carIdentifier).removeValue()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAddCostSegue" {
            (segue.destination as? AddCostViewController)?.costs = selectedCost
        }
    }
    
    @objc func addNewCost() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCost") as! AddCostViewController
        vc.currentUser = currentUser
        vc.car = car
        self.show(vc, sender: self)
        
    }

}
