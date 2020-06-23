//
//  FirestoreApi.swift
//  NewHireProject
//
//  Created by Hoonie on 6/16/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import Foundation
import Firebase

class FirestoreApi {
    let db = Firestore.firestore()
    static let shared = FirestoreApi()
    
    private init() {
    }
    
    func create(collection: String, data: [String:Any], documentName: String) {
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
//        db.collection(collection).document("userID").setData(data)
    }
    func findUser(key: String, value: String) {
        var user: User!
        print("HEHREHREHRHE")
        db.collection("users").whereField(key, isEqualTo: value)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("BRBRBRBRBRBRBRB")
                        let authID = document.data()["authID"]
                        let displayName = document.data()["displayName"]
                        let email = document.data()["email"]
                        user = User(e: email as! String, d: displayName as! String, a: authID as! String)
                        UserSingleton.shared.user = user
                        //print("\(document.documentID) => \(document.data())")
                    }
                }
        }
    }
}
