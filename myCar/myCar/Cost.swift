//
//  Cost.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class Cost: NSObject, NSCoding {
    
    //MARK: Properties
    
    var costType: String
    var costAmount: String
    var costDate: String
    var carIdentifier: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("costs")
    
    //MARK: Types
    
    struct PropertyKey {
        static let costType = "costType"
        static let costAmount = "costAmount"
        static let costDate = "costDate"
        static let carIdentifier = "carIdentifier"
    }
    
    //MARK: Initialization
    
    init?(costType: String?, costAmount: String?, costDate: String?, carIdentifier: String?) {
        
        guard let costType = costType, let costAmount = costAmount, let costDate = costDate, let carIdentifier = carIdentifier else {
            
            return nil
        }
        
        guard !costType.isEmpty && !costAmount.isEmpty && !costDate.isEmpty else {
            return nil
        }
        
        self.costType = costType
        self.costAmount = costAmount
        self.costDate = costDate
        self.carIdentifier = carIdentifier
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(costType, forKey: PropertyKey.costType)
        aCoder.encode(costAmount, forKey: PropertyKey.costAmount)
        aCoder.encode(costDate, forKey: PropertyKey.costDate)
        aCoder.encode(carIdentifier, forKey: PropertyKey.carIdentifier)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let costType = aDecoder.decodeObject(forKey: PropertyKey.costType) as? String
            else {
                os_log("Unable to decode the type for a Cost object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        let costAmount = aDecoder.decodeObject(forKey: PropertyKey.costAmount) as? String
        let costDate = aDecoder.decodeObject(forKey: PropertyKey.costDate) as? String
        let carIdentifier = aDecoder.decodeObject(forKey: PropertyKey.carIdentifier) as? String
        
        self.init(costType: costType, costAmount: costAmount, costDate: costDate, carIdentifier: carIdentifier)
    }

}
