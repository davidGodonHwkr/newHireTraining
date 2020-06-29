//
//  SignInViewController.swift
//  NewHireProject
//
//  Created by Hoonie on 6/15/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func signIn(_ sender: Any) {
        // check for valid inputs in the textfields
        if let username = usernameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
                // if there are no errors with sign in
                if error == nil {
                    // update user singleton
                    let currUser = Auth.auth().currentUser
                    print("USER ID: \(currUser!.uid)")
                    let _ = FirestoreApi.shared.findUser(key: "authID", value: currUser!.uid)
                    // move to the main page
                    self?.dismiss(animated: true) {}
                } else {
                    // print out error message
                    print("this is the error \(error.debugDescription)")
                }
            }
        }
    }
    
    @IBAction func toSignUpPage(_ sender: Any) {
        print("HELOEOEOEOEOEOEOEO")
        self.performSegue(withIdentifier: "signInToSignUp", sender: self)
        //self.dismiss(animated: false) {}
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signInToMain" {
        } else if segue.identifier == "signInToSignUp" {
            print("")
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
