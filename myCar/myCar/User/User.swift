//
//  User.swift
//  myCar
//
//  Created by Michał on 05/05/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
