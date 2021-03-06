//
//  CarTableViewController.swift
//  myCar
//
//  Created by Michał on 21/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class CarTableViewController: UITableViewController {
    
    var refCars: DatabaseReference!
    var selectedCar: Car?
    var currentUser: String?
    var identifier: String?
    var carList = [Car]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.hidesBarsOnSwipe = false
        
        refCars = Database.database().reference().child("Users/\(currentUser!)/cars")
                                                        //("Users/(currentUser!)/cars/\(identifier)/Repairs")
        refCars.observe(DataEventType.value, with: { (snapshot) in
            self.carList.removeAll()
            if snapshot.childrenCount > 0 {
                for cars in snapshot.children.allObjects as! [DataSnapshot] {
                    let carObject = cars.value as? [String: AnyObject]
                    let carBrand = carObject?["carBrand"] as? String
                    let carModel = carObject?["carModel"] as? String
                    let carYear = carObject?["carYear"] as? String
                    let carID = carObject?["id"] as? String
                    
                    // safely try to create Car object - if it fails, nothing is added to the list
                    if let car = Car(brand: carBrand, model: carModel, productionYear: carYear, identifier: carID) {
                        self.carList.append(car)
                    }
                }
            }
            self.tableView.reloadData()

    })
        
            
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
        self.tableView.tableFooterView = UIView()
   
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCar)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        self.toolbarItems = items
        self.navigationController?.toolbar.isTranslucent = false
        
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.any)
    
    
        
        
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
        
        return carList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CarTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CarTableViewCell else {
                fatalError("Error")
        }
        
        let car = carList[indexPath.row]
        
        cell.brandLabel.text = car.brand
        cell.modelLabel.text = car.model
        
       
        
        return cell
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let removeCar = carList[indexPath.row]
            
            refCars.child(removeCar.identifier).removeValue()
            tableView.reloadData()
            
        } else if editingStyle == .insert {
        
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCar = carList[indexPath.row]
        performSegue(withIdentifier: "showCategorySegue", sender: self)
        
    }
    
  
    

    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showCategorySegue" {
        (segue.destination as? CategoryViewController)?.car = selectedCar
        (segue.destination as? CategoryViewController)?.currentUser = currentUser
    
            
    
        }
    }
    
    @objc func addNewCar() {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCarScreen") as! NewCarViewController
                vc.currentUser = currentUser
                vc.identifier = identifier
                self.show(vc, sender: self)
    
    }
}
