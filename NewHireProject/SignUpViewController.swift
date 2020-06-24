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
                    print("this is the error \(error.debugDescription)")
                }
            }
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        //self.performSegue(withIdentifier: "signUpToSignIn", sender: self)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createAccountSegue" {
            let secondVC: CreateAccountViewController = segue.destination as! CreateAccountViewController
            secondVC.email = usernameTextField.text
            secondVC.authID = Auth.auth().currentUser?.uid
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
