//
//  MileageTableViewController.swift
//  myCar
//
//  Created by Michał on 09/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class MileageTableViewController: UITableViewController, FilterMileageViewControllerDelegate {
    func didSelectYear(year: String?) {
        yearPicked = year
    }
    
    var refMileage: DatabaseReference!
    var selectedMileage: Mileage?
    var currentUser: String?
    var mileageList = [Mileage]()
    var car: Car?
    var yearPicked: String?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showTitle()
        
        refMileage = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Mileage")
        
        refMileage.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.mileageList.removeAll()
                for mileages in snapshot.children.allObjects as! [DataSnapshot] {
                    let mileageObject = mileages.value as? [String: AnyObject]
                    let mileageYear = mileageObject?["mileageYear"] as! String?
                    let distance = mileageObject?["distance"]
                    let mileageID = mileageObject?["id"]
                    
                    let mileage = Mileage(mileageYear: mileageYear as! String?, distance: distance as! String?, carIdentifier: mileageID as! String?)
                    
//                    let rangeOfYear = mileageYear
                    let yearStr = String(mileageYear!)
                    
                    if yearStr == self.yearPicked || self.yearPicked == nil || self.yearPicked == "" {
                    self.mileageList.append(mileage!)
                    }
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
        title.translatesAutoresizingMaskIntoConstraints = false
        var sum = 0.0
        title.text = "\(sum)"
        self.navigationItem.titleView = title
        title.widthAnchor.constraint(equalToConstant: 200).isActive = true
        title.textAlignment = .center
        self.setTitleWithValue(value: sum, title: title)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        ref.child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Mileage").observe(.childAdded, with: { (snapshot) in
            
            let mileageObject = snapshot.value as? [String: AnyObject]
            let mileageYear = mileageObject?["mileageYear"] as! String?
            let distance = mileageObject?["distance"] as! String?
            let yearStr = String(mileageYear!)
            
            if let numericalCost = Double(distance!) {
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
        let vc = FilterMileageViewController()
        (vc as FilterMileageViewController).car = car
        (vc as FilterMileageViewController).currentUser = currentUser
        self.show(vc, sender: self)
        vc.delegate = self
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
            self.mileageList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mileage = mileageList[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewMileage") as! AddMileageViewController
        vc.currentUser = currentUser
        vc.car = car
        vc.mileage = mileage
        self.show(vc, sender: self)
        
    }
    
    @objc func addNewMileage() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewMileage") as! AddMileageViewController
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
