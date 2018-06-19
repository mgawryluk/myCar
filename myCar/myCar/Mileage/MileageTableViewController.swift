//
//  MileageTableViewController.swift
//  myCar
//
//  Created by Michał on 09/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class MileageTableViewController: UITableViewController {
    
    var refMileage: DatabaseReference!
    var selectedMileage: Mileage?
    var currentUser: String?
    var mileageList = [Mileage]()
    var car: Car?

    override func viewDidLoad() {
        super.viewDidLoad()
        showTitle()
        
        refMileage = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Mileage")
        
        refMileage.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.mileageList.removeAll()
                for mileages in snapshot.children.allObjects as! [DataSnapshot] {
                    let mileageObject = mileages.value as? [String: AnyObject]
                    let mileageYear = mileageObject?["mileageYear"]
                    let distance = mileageObject?["distance"]
                    let mileageID = mileageObject?["id"]
                    
                    let mileage = Mileage(mileageYear: mileageYear as! String?, distance: distance as! String?, carIdentifier: mileageID as! String?)
                    
                    self.mileageList.append(mileage!)
                    
                }
                self.tableView.reloadData()
            }
            
        })
        
        self.tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = editButtonItem
        
        self.navigationController?.isToolbarHidden = false
        var items =  [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMileage)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        self.toolbarItems = items
    
    }
    
    func showTitle() {
        let title = UILabel()
        title.text = "Mileage"
        self.navigationItem.titleView = title
        
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
        
        return mileageList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MileageTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MileageTableViewCell else {
            fatalError("Error")
        }
        
        let km = mileageList[indexPath.row]
        
        cell.mileageYearLabel.text = km.mileageYear
        cell.distanceTextLabel.text = km.distance
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           let removeMileage = mileageList[indexPath.row]
            refMileage.child(removeMileage.carIdentifier).removeValue()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "showAddMileageSegue" {
//            (segue.destination as? AddMileageViewController)?.car = car
//        }
//    }
    
    @objc func addNewMileage() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewMileage") as! AddMileageViewController
                vc.currentUser = currentUser
                vc.car = car
            self.show(vc, sender: self)
        
    
    }

}
