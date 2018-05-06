//
//  CarRepositosory.swift
//  myCar
//
//  Created by Michał on 25/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import os.log

class CarRepository {
    static let instance = CarRepository()
    
    var cars = [Car]()
    
    init() {
        if let cars = loadCars() {
            self.cars = cars
            
        }
        
    }
    
    func getAllCars() -> [Car] {
        
        return cars
    }
    
    func addNewCar(car: Car) {
        cars.append(car)
    }
    
    func deleteCar(indexPath: Int) {
        cars.remove(at: indexPath)
    }
    
    func saveCars() {
        let saveSuccess = NSKeyedArchiver.archiveRootObject(cars, toFile: Car.ArchiveURL.path)
        
        if saveSuccess {
            os_log("Cars successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save cars...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Private Methods
    
    private func loadCars() -> [Car]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: Car.ArchiveURL.path) as? [Car])
    }

}
