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
  //  var posts = [Posts]()
   
    private init() {
        ref = Database.database().reference(withPath: "posts")
    }
    
    func create(postItem: Posts, completion: @escaping ([Posts]) -> ()) {
//        // 1
        let keyValue = self.ref.childByAutoId().key!
        // add it to the array
        postItem.key = keyValue
        // 2
        let postRef = self.ref.child(keyValue)
        // 3
        postRef.setValue(postItem.toAnyObject())
        self.read() { posts in
            completion(posts)
        }
    }
    
    func read(completion: @escaping ([Posts]) -> () ) {
        var posts = [Posts]()
        self.ref.observeSingleEvent(of: .value, with: {snapshot in
            //print("count: " + String(snapshot.childrenCount))
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let post = Posts()
                        post.authorEmail = postDict["authorEmail"] as? String
                        post.authorName = postDict["authorName"] as? String
                        post.authorRef = postDict["authorRef"] as? String
                        post.date = postDict["date"] as? String
                        post.postDescription = postDict["postDescription"] as? String
                        post.postName = postDict["postName"] as? String
                        post.key = postDict["key"] as? String
                        post.displayName = postDict["displayName"] as? String
                        posts.append(post)
                    }
                }
            }
            completion(posts)
        })
        
    }
    
    func update(key: String, field: String, newValue: String) {
        let postRef = self.ref.child(key)
        
         // 3
        postRef.updateChildValues([field:newValue])
    }
    
    func delete(key: String, completion: @escaping ([Posts]) -> ()) {
        print("DELETING, here is key: \(key)")
        self.ref.child(key).removeValue()
        self.read() { posts in
            completion(posts)
        }
    }
}
