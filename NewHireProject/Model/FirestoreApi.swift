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
    
    func create(collection: String, data: [String:Any]) {
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
