//
//  Posts.swift
//  NewHireProject
//
//  Created by Hoonie on 6/8/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import Foundation

class Posts {
    var authorName: String!
    var authorEmail: String!
    var postName: String!
    var postDescription: String!
    var authorRef: String!
    var date: String!
    var key: String!
    var displayName: String!
    
    var dictionary: [String: String] = [:]
    
    init() {
        
    }
    
    init(_ name:String, _ email:String, _ post:String, _ description:String, _ ref:String, _ date:String, _ keyValue: String, _ display: String) {
        self.authorName = name
        self.authorEmail = email
        self.postName = post
        self.postDescription = description
        self.authorRef = ref
        self.date = date
        self.key = keyValue
        self.displayName = display
    }
    
    func toAnyObject() -> [String: String] {
        dictionary["authorName"] = authorName
        dictionary["authorEmail"] = authorEmail
        dictionary["postName"] = postName
        dictionary["postDescription"] = postDescription
        dictionary["authorRef"] = authorRef
        dictionary["date"] = date
        dictionary["key"] = key
        dictionary["displayName"] = displayName
        return dictionary
    }
}
