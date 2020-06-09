//
//  DbApi.swift
//  NewHireProject
//
//  Created by Hoonie on 6/8/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DbApi {
    static let shared = DbApi()
    var ref: DatabaseReference!
    var posts = [Posts]()
   
    private init() {
        ref = Database.database().reference(withPath: "posts")
        
    }
    
    func create(authorName: String, authorEmail: String, postName: String, postDescription: String, authorRef: String, date: String) {
        // 1
        let postItem = Posts(authorName, authorEmail, postName, postDescription, authorRef, date)
        
        // 2
        let postRef = self.ref.child(authorRef.lowercased())
        
        // 3
        postRef.setValue(postItem.toAnyObject())
    }
    
    func read( completion: @escaping () -> () ) {
        posts = []
        self.ref.observe(.value, with: {snapshot in
            //print("count: " + String(snapshot.childrenCount))
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let post = Posts("0","0","0","0","0","0")
                        post.authorEmail = postDict["authorEmail"] as? String
                        post.authorName = postDict["authorName"] as? String
                        post.authorRef = postDict["authorRef"] as? String
                        post.date = postDict["date"] as? String
                        post.postDescription = postDict["postDescription"] as? String
                        post.postName = postDict["postName"] as? String
                        self.posts.append(post)
                    }
                }
            }
            completion()
        })
        
    }
    
    func update(authorRef: String, field: String, newValue: String) {
        let postRef = self.ref.child(authorRef.lowercased())
        
         // 3
        postRef.updateChildValues([field:newValue])
    }
    
    func delete(authorRef: String) {
        self.ref.child(authorRef).removeValue()
    }
}
