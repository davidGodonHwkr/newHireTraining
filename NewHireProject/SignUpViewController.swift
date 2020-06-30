//
//  SignUpViewController.swift
//  NewHireProject
//
//  Created by Hoonie on 6/15/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordTextField.isSecureTextEntry = true
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                if error == nil {
                    self.performSegue(withIdentifier: "createAccountSegue", sender: self)
                } else {
                }
            }
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createAccountSegue" {
            let secondVC: CreateAccountViewController = segue.destination as! CreateAccountViewController
            secondVC.email = usernameTextField.text
            secondVC.authID = Auth.auth().currentUser?.uid
        }
        
    }

}
