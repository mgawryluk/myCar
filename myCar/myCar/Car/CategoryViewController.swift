//
//  CategoryViewController.swift
//  myCar
//
//  Created by Michał on 09/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var car: Car?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = car?.brand
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMileageSegue" {
            (segue.destination as? MileageTableViewController)?.car = car
        } else if segue.identifier == "showBillsSegue" {
            (segue.destination as? BillsTableViewController)?.car = car
        } else if segue.identifier == "showCostsSegue" {
            (segue.destination as? CostsTableViewController)?.car = car
        } else if segue.identifier == "showRepairsSegue" {
            (segue.destination as? RepairsTableViewController)?.car = car
        }
    }
    

}
