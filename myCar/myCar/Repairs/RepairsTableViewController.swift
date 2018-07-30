//
//  RepairsTableViewController.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class RepairsTableViewController: UITableViewController, FilterRepairViewControllerDelegate {
    func didSelectYear(year: String?) {
        yearPicked = year
    }

    var refRepairs: DatabaseReference!
    var selectedRepair: Repair?
    var currentUser: String?
    var repairList = [Repair]()
    var car: Car?
    var yearPicked: String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showTitle()

        
        refRepairs = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Repairs")
        
        refRepairs.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.repairList.removeAll()
                for repairs in snapshot.children.allObjects as! [DataSnapshot] {
                    let repairObject = repairs.value as? [String: AnyObject]
                    let repairType = repairObject?["repairType"]
                    let repairDate = repairObject?["repairDate"] as! String?
                    let repairCost = repairObject?["repairCost"]
                    let repairID = repairObject?["id"]
                    
                    let repair = Repair(repairType: repairType as! String?, repairCost: repairCost as! String?, repairDate: repairDate as! String?, carIdentifier: repairID as! String?)
                    
                    let rangeOfYear = repairDate?.suffix(4)
                    let yearStr = String(rangeOfYear!)
                    
                    if yearStr == self.yearPicked || self.yearPicked == nil || self.yearPicked == "" {
                            self.repairList.append(repair!)
                    
                    } }
                self.tableView.reloadData()
            }
            
        })
        
        navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.tableFooterView = UIView()
        
        
        self.navigationController?.isToolbarHidden = false
        var items =  [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRepair)))
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
        
        
        ref.child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Repairs").observe(.childAdded, with: { (snapshot) in
            
            let repairObject = snapshot.value as? [String: AnyObject]
            let repairCost = repairObject?["repairCost"] as! String?
            let repairDate = repairObject?["repairDate"] as! String?
            let rangeOfYear = repairDate?.suffix(4)
            let yearStr = String(rangeOfYear!)
            
            if let numericalCost = Double(repairCost!) {
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
        let vc = FilterRepairViewController()
        (vc as FilterRepairViewController).car = car
        (vc as FilterRepairViewController).currentUser = currentUser
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
        
        return repairList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RepairTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepairTableViewCell else {
            fatalError("Error")
        }
        
        let repairs = repairList[indexPath.row]
    
        
        cell.repairTypeLabel.text = repairs.repairType
        cell.repairDateLabel.text = repairs.repairDate
        cell.repairCostLabel.text = repairs.repairCost
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repair = repairList[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewRepair") as! AddRepairViewController
        vc.currentUser = currentUser
        vc.car = car
        vc.repair = repair
        self.show(vc, sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeRepair = repairList[indexPath.row]
            refRepairs.child(removeRepair.carIdentifier).removeValue()
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.repairList.remove(at: indexPath.row)
            self.tableView.reloadData()
            
            
        } else if editingStyle == .insert {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAddRepairSegue" {
            (segue.destination as? AddRepairViewController)?.repairs = selectedRepair
        }
    }
    
   
    @objc func addNewRepair() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewRepair") as! AddRepairViewController
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
