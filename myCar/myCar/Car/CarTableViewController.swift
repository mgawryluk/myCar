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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        refCars = Database.database().reference().child("Users/\(currentUser!)/cars")
                                                        //("Users/(currentUser!)/cars/\(identifier)/Repairs")
        refCars.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.carList.removeAll()
                for cars in snapshot.children.allObjects as! [DataSnapshot] {
                    let carObject = cars.value as? [String: AnyObject]
                    let carBrand = carObject?["carBrand"]
                    let carModel = carObject?["carModel"]
                    let carYear = carObject?["carYear"]
                    let carID = carObject?["id"]
                    
                    let car = Car(brand: carBrand as! String?, model: carModel as! String?, productionYear: carYear as! String?, identifier: carID as! String?)
                    
                    self.carList.append(car!)
                
            }
                self.tableView.reloadData()
            }

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
        
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.any)
    
    
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isToolbarHidden = false
        tableView.reloadData()
        // New data added to Car array
        
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
            
        } else if editingStyle == .insert {
        
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCar = carList[indexPath.row]
        performSegue(withIdentifier: "showCategorySegue", sender: self)
        
    }
    
  
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
