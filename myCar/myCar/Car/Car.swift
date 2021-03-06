//
//  Car.swift
//  myCar
//
//  Created by Michał on 21/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class Car: NSObject, NSCoding {
    
    //MARK: Properties
    
    var brand: String
    var model: String
    var productionYear: String
    var identifier: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("cars")
    
    //MARK: Types
    
    struct PropertyKey {
        static let brand = "brand"
        static let model = "model"
        static let productionYear = "productionYear"
        static let identifier = "identifier"
    }
    
    //MARK: Initialization
    
    init?(brand: String?, model: String?, productionYear: String?, identifier: String? = nil) {
        
        guard let brand = brand, let model = model, let productionYear = productionYear else {
    
            return nil
        }
        
        guard !brand.isEmpty && !model.isEmpty && !productionYear.isEmpty else {
            return nil
        }
        
        self.brand = brand
        self.model = model
        self.productionYear = productionYear
        
        if identifier != nil {
            self.identifier = identifier!
        } else {
            self.identifier = UUID().uuidString
        }
    }
    
   
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(brand, forKey: PropertyKey.brand)
        aCoder.encode(model, forKey: PropertyKey.model)
        aCoder.encode(productionYear, forKey: PropertyKey.productionYear)
        aCoder.encode(identifier, forKey: PropertyKey.identifier)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let brand = aDecoder.decodeObject(forKey: PropertyKey.brand) as? String
            else {
                os_log("Unable to decode the model for a Car object.", log: OSLog.default, type: .debug)
            
                return nil
        }
        
        let model = aDecoder.decodeObject(forKey: PropertyKey.model) as? String
        let productionYear = aDecoder.decodeObject(forKey: PropertyKey.productionYear) as? String
        let identifier = aDecoder.decodeObject(forKey: PropertyKey.identifier) as? String
        
        self.init(brand: brand, model: model, productionYear: productionYear, identifier: identifier)
    }
    
}
