//
//  Bills.swift
//  myCar
//
//  Created by Michał on 19/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class Bill: NSObject, NSCoding {
    
    //MARK: Properties
    
    var billType: String
    var billCost: String
    var billDate: String
    var carIdentifier: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bills")
    
    //MARK: Types
    
    struct PropertyKey {
        static let billType = "billType"
        static let billCost = "billCost"
        static let billDate = "billDate"
        static let carIdentifier = "carIdentifier"
    }
    
    //MARK: Initialization
    
    init?(billType: String?, billCost: String?, billDate: String?, carIdentifier: String?) {
        
        guard let billType = billType, let billCost = billCost, let billDate = billDate, let carIdentifier = carIdentifier else {
            
            return nil
        }
        
        guard !billType.isEmpty && !billCost.isEmpty && !billDate.isEmpty else {
            return nil
        }
        
        self.billType = billType
        self.billCost = billCost
        self.billDate = billDate
        self.carIdentifier = carIdentifier
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(billType, forKey: PropertyKey.billType)
        aCoder.encode(billCost, forKey: PropertyKey.billCost)
        aCoder.encode(billDate, forKey: PropertyKey.billDate)
        aCoder.encode(carIdentifier, forKey: PropertyKey.carIdentifier)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let billType = aDecoder.decodeObject(forKey: PropertyKey.billType) as? String
            else {
                os_log("Unable to decode the type for a Bill object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        let billCost = aDecoder.decodeObject(forKey: PropertyKey.billCost) as? String
        let billDate = aDecoder.decodeObject(forKey: PropertyKey.billDate) as? String
        let carIdentifier = aDecoder.decodeObject(forKey: PropertyKey.carIdentifier) as? String
        
        self.init(billType: billType, billCost: billCost, billDate: billDate, carIdentifier: carIdentifier)
    }

}
