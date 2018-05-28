//
//  myCarTests.swift
//  myCarTests
//
//  Created by Marcin Lepicki on 28/05/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import XCTest
@testable import myCar

class myCarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCarInitialization() {
        let car = Car(brand: "Ford", model: "Focus", productionYear: "1999")
        assert(car?.brand == "Ford", "Wrong car brand")
        assert(car?.model == "Focus", "Wrong car model")
        assert(car?.productionYear == "1999", "Wrong car production year")
    }
    
}
