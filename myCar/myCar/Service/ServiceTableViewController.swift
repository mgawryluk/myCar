//
//  ServiceTableViewController.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class ServiceTableViewController: UITableViewController {
    
    var refServices: DatabaseReference!
    var selectedService: Service?
    var currentUser: String?
    var car: Car?
    var serviceList = [Service]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        refServices = Database.database().reference().child("Users/\(currentUser!)/cars/\((car?.identifier)!)/Services")
        
        refServices.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.serviceList.removeAll()
                for services in snapshot.children.allObjects as! [DataSnapshot] {
                    let serviceObject = services.value as? [String: AnyObject]
                    let serviceType = serviceObject?["serviceType"]
                    let serviceDate = serviceObject?["serviceDate"]
                    let serviceCost = serviceObject?["serviceCost"]
                    let serviceID = serviceObject?["id"]
                    
                    let service = Service(serviceType: serviceType as! String?, serviceCost: serviceCost as! String?, serviceDate: serviceDate as! String?, carIdentifier: serviceID as! String?)
                    
                    self.serviceList.append(repair!)
                    
                }
                self.tableView.reloadData()
            }
            
        })
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.tableFooterView = UIView()
        
        self.navigationController?.isToolbarHidden = false
        var items =  [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addService)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        self.toolbarItems = items
        
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceTableViewCell")
        
      

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
        
        return serviceList.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as? ServiceTableViewCell else {
            fatalError("Error")
        }
        
        let services = serviceList[indexPath.row]
        
        cell.serviceTypeLabel.text = services.serviceType
        cell.serviceDateLabel.text = services.serviceDate
        cell.serviceCostLabel.text = services.serviceCost
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removeService = serviceList[indexPath.row]
            refServices.child(removeService.carIdentifier).removeValue()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func addService() {
        
        let vc = AddServiceViewController()
        (vc as? AddServiceViewController)?.car = car
        vc.currentUser = currentUser
        self.show(vc, sender: self)
        
        }
    
}
