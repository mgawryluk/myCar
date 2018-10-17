//
//  InsuranceRepository.swift
//  myCar
//
//  Created by Michał on 09/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import os.log

class InsuranceRepository {
    
    static let instance = InsuranceRepository()
    
    var insurances = [Insurance]()
    
    init() {
        if let insurances = loadInsurances() {
            self.insurances = insurances
            
        }
        
    }
    
    func getInsurancesForCar(carIdentifier: String) -> [Insurance] {
        
        
        var filteredInsurances = [Insurance]()
        for item in insurances {
            if item.carIdentifier == carIdentifier {
                filteredInsurances.append(item)
            }
            
        }
        
        return filteredInsurances
        
    }
    
    func getAllInsurances() -> [Insurance] {
        
        return insurances
    }
    
    
    
    func addInsurance(newInsurance: Insurance) {
        insurances.append(newInsurance)
    }
    
    func deleteInsurance(indexPath: Int) {
        insurances.remove(at: indexPath)
    }
    
    
    func saveInsurance() {
        let saveSuccess = NSKeyedArchiver.archiveRootObject(insurances, toFile: Insurance.ArchiveURL.path)
        
        if saveSuccess {
            os_log("Insurance successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save insurance...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Private Methods
    
    private func loadInsurances() -> [Insurance]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Insurance.ArchiveURL.path) as? [Insurance])
    }
    
}
