//
//  ServiceRepository.swift
//  myCar
//
//  Created by Michał on 09/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import os.log

class ServiceRepository {
    
    static let instance = ServiceRepository()
    
    var services = [Service]()
    
    init() {
        if let services = loadServices() {
            self.services = services
            
        }
        
    }
    
    func getServicesForCar(carIdentifier: String) -> [Service] {
        
        
        var filteredServices = [Service]()
        for item in services {
            if item.carIdentifier == carIdentifier {
                filteredServices.append(item)
            }
            
        }
        
        return filteredServices
        
    }
    
    func getAllServices() -> [Service] {
        
        return services
    }
    
    
    
    func addService(newService: Service) {
        services.append(newService)
    }
    
    func deleteService(indexPath: Int) {
        services.remove(at: indexPath)
    }
    
    
    func saveService() {
        let saveSuccess = NSKeyedArchiver.archiveRootObject(services, toFile: Service.ArchiveURL.path)
        
        if saveSuccess {
            os_log("Service successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save service...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Private Methods
    
    private func loadServices() -> [Service]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Service.ArchiveURL.path) as? [Service])
    }
    
}
