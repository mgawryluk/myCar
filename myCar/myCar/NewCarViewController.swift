//
//  ViewController.swift
//  myCar
//
//  Created by Michał on 19/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class NewCarViewController: UIViewController {
    
    // MARK: Properities
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var productionYearTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func addCar(_ sender: UIButton) {
    }
    
    

}

