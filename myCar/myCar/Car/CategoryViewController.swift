//
//  CategoryViewController.swift
//  myCar
//
//  Created by Michał on 09/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController {
    
    var car: Car?
    var currentUser: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = car?.brand
        
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.any)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMileageSegue" {
            (segue.destination as? MileageTableViewController)?.car = car
            (segue.destination as? MileageTableViewController)?.currentUser = currentUser
        } else if segue.identifier == "showBillsSegue" {
            (segue.destination as? BillsTableViewController)?.car = car
            (segue.destination as? BillsTableViewController)?.currentUser = currentUser
        } else if segue.identifier == "showRepairsSegue" {
            (segue.destination as? RepairsTableViewController)?.car = car
            (segue.destination as? RepairsTableViewController)?.currentUser = currentUser
        } else if segue.identifier == "showInsuranceSegue" {
            (segue.destination as? InsuranceTableViewController)?.car = car
            (segue.destination as? InsuranceTableViewController)?.currentUser = currentUser
        }
    }
    

}
