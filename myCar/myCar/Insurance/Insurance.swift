//
//  Insurance.swift
//  myCar
//
//  Created by Michał on 09/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class Insurance: NSObject, NSCoding {
    //MARK: Properties
    
    var insuranceType: String
    var insuranceCost: String
    var insuranceDate: String
    var carIdentifier: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("insurance")
    
    //MARK: Types
    
    struct PropertyKey {
        static let insuranceType = "insuranceType"
        static let insuranceCost = "insuranceCost"
        static let insuranceDate = "insuranceDate"
        static let carIdentifier = "carIdentifier"
    }
    
    //MARK: Initialization
    
    init?(insuranceType: String?, insuranceCost: String?, insuranceDate: String?, carIdentifier: String?) {
        
        guard let insuranceType = insuranceType, let insuranceCost = insuranceCost, let insuranceDate = insuranceDate, let carIdentifier = carIdentifier else {
            
            return nil
        }
        
        guard !insuranceType.isEmpty && !insuranceCost.isEmpty && !insuranceDate.isEmpty else {
            return nil
        }
        
        self.insuranceType = insuranceType
        self.insuranceCost = insuranceCost
        self.insuranceDate = insuranceDate
        self.carIdentifier = carIdentifier
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(insuranceType, forKey: PropertyKey.insuranceType)
        aCoder.encode(insuranceCost, forKey: PropertyKey.insuranceCost)
        aCoder.encode(insuranceDate, forKey: PropertyKey.insuranceDate)
        aCoder.encode(carIdentifier, forKey: PropertyKey.carIdentifier)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let insuranceType = aDecoder.decodeObject(forKey: PropertyKey.insuranceType) as? String
            else {
                os_log("Unable to decode the type for a Insurance object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        let insuranceCost = aDecoder.decodeObject(forKey: PropertyKey.insuranceCost) as? String
        let insuranceDate = aDecoder.decodeObject(forKey: PropertyKey.insuranceDate) as? String
        let carIdentifier = aDecoder.decodeObject(forKey: PropertyKey.carIdentifier) as? String
        
        self.init(insuranceType: insuranceType, insuranceCost: insuranceCost, insuranceDate: insuranceDate, carIdentifier: carIdentifier)
    }

}
