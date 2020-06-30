//
//  CreateAccountViewController.swift
//  NewHireProject
//
//  Created by Hoonie on 6/16/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    var email: String?
    var authID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        if let name = displayNameTextField.text {
            FirestoreApi.shared.create(collection: "users", data: ["email": email!, "displayName": name, "authID": authID!], documentName: authID!)
            UserSingleton.shared.user = User(e: email!, d: name, a: authID!)
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
