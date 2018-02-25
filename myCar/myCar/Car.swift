//
//  Car.swift
//  myCar
//
//  Created by Michał on 21/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class Car {
    var brand: String
    var model: String
    var productionYear: String
    
    //MARK: Initialization
    
    init?(brand: String?, model: String?, productionYear: String?) {
        
        guard let brand = brand, let model = model, let productionYear = productionYear else {
    
            return nil
        }
        
        guard !brand.isEmpty && !model.isEmpty && !productionYear.isEmpty else {
            return nil
        }
        
        self.brand = brand
        self.model = model
        self.productionYear = productionYear
    }
}
