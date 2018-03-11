//
//  MileageRepository.swift
//  myCar
//
//  Created by Michał on 10/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import os.log

class MileageRepository {

    static let instance = MileageRepository()
    
    var mileage = [Mileage]()
    
    init() {
        if let mileage = loadMileage() {
            self.mileage = mileage
            
        }
    
    }
    
    func getMileageForCar(carIdentifier: String) -> [Mileage] {
        
        return mileage.filter {$0.carIdentifier == carIdentifier}
        
//        var filteredMileages = [Mileage]()
//        for item in mileage {
//            if item.carIdentifier == carIdentifier {
//                filteredMileages.append(item)
//            }
//
//        }
//
//        return filteredMileages
    }
    
    func addMileage(km: Mileage) {
        mileage.append(km)
    }

    
    func saveMileage() {
        let saveSuccess = NSKeyedArchiver.archiveRootObject(mileage, toFile: Mileage.ArchiveURL.path)
        
        if saveSuccess {
            os_log("Mileage successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save mileage...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Private Methods
    
    private func loadMileage() -> [Mileage]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Mileage.ArchiveURL.path) as? [Mileage])
    }
    
}
