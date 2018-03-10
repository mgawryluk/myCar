//
//  Mileage.swift
//  myCar
//
//  Created by Michał on 10/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit
import os.log

class Mileage: NSObject, NSCoding {

    //MARK: Properties
    
    var mileageYear: String
    var distance: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("mileage")
    
    //MARK: Types
    
    struct PropertyKey {
        static let mileageYear = "mileageYear"
        static let distance = "distance"
    }
    
    //MARK: Initialization
    
    init?(mileageYear: String?, distance: String?) {
        
        guard let mileageYear = mileageYear, let distance = distance else {
            
            return nil
        }
        
        guard !mileageYear.isEmpty && !distance.isEmpty else {
            return nil
        }
        
        self.mileageYear = mileageYear
        self.distance = distance
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(mileageYear, forKey: PropertyKey.mileageYear)
        aCoder.encode(distance, forKey: PropertyKey.distance)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let mileageYear = aDecoder.decodeObject(forKey: PropertyKey.mileageYear) as? String
            else {
                os_log("Unable to decode the model for a Car object.", log: OSLog.default, type: .debug)
                
                return nil
        }
        
        let distance = aDecoder.decodeObject(forKey: PropertyKey.distance) as? String
        
        self.init(mileageYear: mileageYear, distance: distance)
    }
    

}
