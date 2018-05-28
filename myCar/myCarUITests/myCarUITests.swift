//
//  myCarUITests.swift
//  myCarUITests
//
//  Created by Marcin Lepicki on 28/05/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import XCTest

class myCarUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testLogin() {
//
//        
//        let app = XCUIApplication()
//        app.buttons["Log In"].tap()
//        app.textFields["Enter email"].tap()
//        app.secureTextFields["Enter password"].tap()
//        app.buttons["Log in"].tap()
//    
//    }
    
    
    
}
