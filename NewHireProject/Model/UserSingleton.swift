//
//  UserSingleton.swift
//  NewHireProject
//
//  Created by Hoonie on 6/16/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import Foundation

class UserSingleton {
    static let shared = UserSingleton()
    var user: User?
}
