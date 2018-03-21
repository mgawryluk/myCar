//
//  BillRepository.swift
//  myCar
//
//  Created by Michał on 20/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import os.log

class BillRepository {
    
    static let instance = BillRepository()
    
    var bills = [Bill]()
    
    init() {
        if let bills = loadBills() {
            self.bills = bills
            
        }
        
    }
    
    func getBillsForCar(carIdentifier: String) -> [Bill] {
        
        
                var filteredBills = [Bill]()
                for item in bills {
                    if item.carIdentifier == carIdentifier {
                        filteredBills.append(item)
                    }
        
                }
        
                return filteredBills
    }
    //        return bills.filter {$0.carIdentifier == carIdentifier}

    
    func addBills(newBill: Bill) {
        bills.append(newBill)
    }
    
    
    func saveBills() {
        let saveSuccess = NSKeyedArchiver.archiveRootObject(bills, toFile: Bill.ArchiveURL.path)
        
        if saveSuccess {
            os_log("Bill successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save bill...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Private Methods
    
    private func loadBills() -> [Bill]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Bill.ArchiveURL.path) as? [Bill])
    }

}
