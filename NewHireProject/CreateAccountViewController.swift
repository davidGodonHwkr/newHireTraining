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
            //self.performSegue(withIdentifier: "createAccountToMain", sender: self)
            //self.dismiss(animated: true, completion: {})
            //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
