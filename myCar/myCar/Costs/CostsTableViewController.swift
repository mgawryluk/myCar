//
//  CostsTableViewController.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class CostsTableViewController: UITableViewController, FilterCostViewControllerDelegate {
    func didSelectYear(year: String?) {
        yearPicked = year
        
    }
    

    var refCosts: DatabaseReference!
    var selectedCost: Cost?
    var currentUser: String?
    var car: Car?
    var costList = [Cost]()
    var yearPicked: String?
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showTitle()
        
        refCosts = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Costs")
        
        refCosts.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.costList.removeAll()
                for costs in snapshot.children.allObjects as! [DataSnapshot] {
                    let costObject = costs.value as? [String: AnyObject]
                    let costType = costObject?["costType"]
                    let costDate = costObject?["costDate"] as! String?
                    let costAmount = costObject?["costAmount"]
                    let costID = costObject?["id"]
                    
                    let cost = Cost(costType: costType as! String?, costAmount: costAmount as! String?, costDate: costDate as! String?, carIdentifier: costID as! String?)
                    
                    let rangeOfYear = costDate?.suffix(4)
                    let yearStr = String(rangeOfYear!)
                    
                    if yearStr == self.yearPicked || self.yearPicked == nil || self.yearPicked == "" {
                        self.costList.append(cost!)
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
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCost)))
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


    ref.child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Costs").observe(.childAdded, with: { (snapshot) in
        
        let costObject = snapshot.value as? [String: AnyObject]
        let costAmount = costObject?["costAmount"] as! String?
        let costDate = costObject?["costDate"] as! String?
        let rangeOfYear = costDate?.suffix(4)
        let yearStr = String(rangeOfYear!)
        
        if let numericalCost = Double(costAmount!) {
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
        let vc = FilterCostViewController()
        (vc as FilterCostViewController).car = car
        (vc as FilterCostViewController).currentUser = currentUser
        self.show(vc, sender: self)
        vc.delegate = self
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
            self.costList.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cost = costList[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCost") as! AddCostViewController
        vc.currentUser = currentUser
        vc.car = car
        vc.cost = cost
        self.show(vc, sender: self)
        
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
