//
//  User.swift
//  NewHireProject
//
//  Created by Hoonie on 6/16/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import Foundation

struct User {
    var email: String?
    var displayName: String?
    var authID: String?
    
    init() {
        email = ""
        displayName = ""
        authID = ""
    }
    
    init(e: String, d: String, a: String) {
        email = e
        displayName = d
        authID = a
    }
}
