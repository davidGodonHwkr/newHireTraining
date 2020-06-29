//
//  Utility.swift
//  NewHireProject
//
//  Created by Hoonie on 6/16/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
