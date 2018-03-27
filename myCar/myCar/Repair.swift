//
//  Repair.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class Repair: NSObject, NSCoding {
    
    //MARK: Properties
    
    var repairType: String
    var repairCost: String
    var repairDate: String
    var carIdentifier: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("repairs")
    
    //MARK: Types
    
    struct PropertyKey {
        static let repairType = "repairType"
        static let repairCost = "repairCost"
        static let repairDate = "repairDate"
        static let carIdentifier = "carIdentifier"
    }
    
    //MARK: Initialization
    
    init?(repairType: String?, repairCost: String?, repairDate: String?, carIdentifier: String?) {
        
        guard let repairType = repairType, let repairCost = repairCost, let repairDate = repairDate, let carIdentifier = carIdentifier else {
            
            return nil
        }
        
        guard !repairType.isEmpty && !repairCost.isEmpty && !repairDate.isEmpty else {
            return nil
        }
        
        self.repairType = repairType
        self.repairCost = repairCost
        self.repairDate = repairDate
        self.carIdentifier = carIdentifier
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(repairType, forKey: PropertyKey.repairType)
        aCoder.encode(repairCost, forKey: PropertyKey.repairCost)
        aCoder.encode(repairDate, forKey: PropertyKey.repairDate)
        aCoder.encode(carIdentifier, forKey: PropertyKey.carIdentifier)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let repairType = aDecoder.decodeObject(forKey: PropertyKey.repairType) as? String
            else {
                os_log("Unable to decode the type for a Repair object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        let repairCost = aDecoder.decodeObject(forKey: PropertyKey.repairCost) as? String
        let repairDate = aDecoder.decodeObject(forKey: PropertyKey.repairDate) as? String
        let carIdentifier = aDecoder.decodeObject(forKey: PropertyKey.carIdentifier) as? String
        
        self.init(repairType: repairType, repairCost: repairCost, repairDate: repairDate, carIdentifier: carIdentifier)
    }
    
}
