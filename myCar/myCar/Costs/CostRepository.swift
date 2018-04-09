//
//  CostRepository.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import os.log

class CostRepository {
    
    static let instance = CostRepository()

    var costs = [Cost]()

init() {
    if let costs = loadCosts() {
        self.costs = costs
        
    }
    
}

func getCostsForCar(carIdentifier: String) -> [Cost] {
    
    
    var filteredCosts = [Cost]()
    for item in costs {
        if item.carIdentifier == carIdentifier {
            filteredCosts.append(item)
        }
        
    }
    
    return filteredCosts
}
    
    func getAllCosts() -> [Cost] {
        
        return costs
    }



func addCosts(newCost: Cost) {
    costs.append(newCost)
}
    
    func deleteCost(indexPath: Int) {
        costs.remove(at: indexPath)
    }


func saveCosts() {
    let saveSuccess = NSKeyedArchiver.archiveRootObject(costs, toFile: Cost.ArchiveURL.path)
    
    if saveSuccess {
        os_log("Cost successfully saved.", log: OSLog.default, type: .debug)
    } else {
        os_log("Failed to save cost...", log: OSLog.default, type: .error)
    }
}

//MARK: Private Methods

private func loadCosts() -> [Cost]? {
    return (NSKeyedUnarchiver.unarchiveObject(withFile: Cost.ArchiveURL.path) as? [Cost])
}

}
