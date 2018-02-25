//
//  CarRepositosory.swift
//  myCar
//
//  Created by Michał on 25/02/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation

class CarRepository {
    static let instance = CarRepository()
    
    var cars = [Car]()
    
    init() {
       // let car1 = Car(brand: "Ford", model: "Focus", productionYear: "2009")
       // let car2 = Car(brand: "Opel", model: "Meriva", productionYear: "2006")
       // cars = [car1!, car2!]
    }
    
    func getAllCars() -> [Car] {
        
        return cars
    }
    
    func addNewCar(car: Car) {
        cars.append(car)
    }

}
