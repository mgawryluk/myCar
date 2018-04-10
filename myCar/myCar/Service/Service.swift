//
//  Service.swift
//  myCar
//
//  Created by Michał on 09/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class Service: NSObject, NSCoding {
    //MARK: Properties
    
    var serviceType: String
    var serviceCost: String
    var serviceDate: String
    var carIdentifier: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("services")
    
    //MARK: Types
    
    struct PropertyKey {
        static let serviceType = "serviceType"
        static let serviceCost = "serviceCost"
        static let serviceDate = "serviceDate"
        static let carIdentifier = "carIdentifier"
    }
    
    //MARK: Initialization
    
    init?(serviceType: String?, serviceCost: String?, serviceDate: String?, carIdentifier: String?) {
        
        guard let serviceType = serviceType, let serviceCost = serviceCost, let serviceDate = serviceDate, let carIdentifier = carIdentifier else {
            
            return nil
        }
        
        guard !serviceType.isEmpty && !serviceCost.isEmpty && !serviceDate.isEmpty else {
            return nil
        }
        
        self.serviceType = serviceType
        self.serviceCost = serviceCost
        self.serviceDate = serviceDate
        self.carIdentifier = carIdentifier
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(serviceType, forKey: PropertyKey.serviceType)
        aCoder.encode(serviceCost, forKey: PropertyKey.serviceCost)
        aCoder.encode(serviceDate, forKey: PropertyKey.serviceDate)
        aCoder.encode(carIdentifier, forKey: PropertyKey.carIdentifier)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let serviceType = aDecoder.decodeObject(forKey: PropertyKey.serviceType) as? String
            else {
                os_log("Unable to decode the type for a Service object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        let serviceCost = aDecoder.decodeObject(forKey: PropertyKey.serviceCost) as? String
        let serviceDate = aDecoder.decodeObject(forKey: PropertyKey.serviceDate) as? String
        let carIdentifier = aDecoder.decodeObject(forKey: PropertyKey.carIdentifier) as? String
        
        self.init(serviceType: serviceType, serviceCost: serviceCost, serviceDate: serviceDate, carIdentifier: carIdentifier)
    }

}
