//
//  RepairRepository.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import os.log

class RepairRepository {
    
    static let instance = RepairRepository()
    
    var repairs = [Repair]()
    
    init() {
        if let repairs = loadRepairs() {
            self.repairs = repairs
            
        }
        
    }
    
    func getRepairsForCar(carIdentifier: String) -> [Repair] {
        
        
        var filteredRepairs = [Repair]()
        for item in repairs {
            if item.carIdentifier == carIdentifier {
                filteredRepairs.append(item)
            }
            
        }
        
        return filteredRepairs
    }
    
    func getAllRepairs() -> [Repair] {
        
        return repairs
    }

    
    
    func addRepairs(newRepair: Repair) {
        repairs.append(newRepair)
    }
    
    func deleteRepair(indexPath: Int) {
        repairs.remove(at: indexPath)
    }
    
    func saveRepairs() {
        let saveSuccess = NSKeyedArchiver.archiveRootObject(repairs, toFile: Repair.ArchiveURL.path)
        
        if saveSuccess {
            os_log("Repair successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save repair...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Private Methods
    
    private func loadRepairs() -> [Repair]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Repair.ArchiveURL.path) as? [Repair])
    }
    
}
