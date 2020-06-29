//
//  ViewController.swift
//  NewHireProject
//
//  Created by David Godon on 6/3/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TableViewController: UITableViewController {
    var currentRow: Int! = 0
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    var posts = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        DbApi.shared.read() { posts in
            DispatchQueue.main.async {[weak self] in
                if let strongSelf = self {
                    strongSelf.posts = posts
                    strongSelf.tableView.reloadData()
                }
            }
        }
        
        if let currentUser = Auth.auth().currentUser {
            let _ = FirestoreApi.shared.findUser(key: "authID", value: currentUser.uid)
        } else {
            self.performSegue(withIdentifier: "mainToSignIn", sender: self)
        }
    }

    private func setUpView() {
        navigationItem.title = "Home"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("count of dbapi.post \(DbApi.shared.posts.count)")
        if posts.count > 0 {
            return posts.count
        } else {return 0}
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.authorLabel.text = post.authorName
        cell.dateLabel.text = post.date
        cell.postLabel.text = post.postName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            DbApi.shared.delete(key: posts[indexPath.row].key) { posts in
                DispatchQueue.main.async {
                    self.posts = posts
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // check if user is signed in
        if Auth.auth().currentUser == nil {
            self.performSegue(withIdentifier: "mainToSignIn", sender: self)
            return
        }
        currentRow = indexPath.row
        self.performSegue(withIdentifier: "InfoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoSegue" {
            let secondVC: InfoViewController = segue.destination as! InfoViewController
            secondVC.rowSelected = currentRow
            secondVC.posts = self.posts
        } else if segue.identifier == "mainToSignIn" {
        }
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        // check if user is signed in
        if Auth.auth().currentUser == nil {
            self.performSegue(withIdentifier: "mainToSignIn", sender: self)
            return
        }
        
        let alertController = UIAlertController(title: "Create Post", message: "Please fill in inputs", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "post name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "post description"
        }
        alertController.addTextField() { textField in
            textField.placeholder = "author name"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("ok action")
            let textfield1 = alertController.textFields![0]
            let textfield2 = alertController.textFields![1]
            let textfield3 = alertController.textFields![2]
            // find current date
            let date = Date()
           // let calendar = Calendar.current
            let currDate = date.string(format: "yyyy-MM-dd")
            // add it to singleton and database
            print("USER SINGLETON DISPLAY NAME: \((UserSingleton.shared.user?.displayName)!)")
            let newPost = Posts(textfield3.text!, (UserSingleton.shared.user?.email)!, textfield1.text!, textfield2.text!, "author5", currDate, "", (UserSingleton.shared.user?.displayName)!)
           // DbApi.shared.posts.append(newPost)
            DbApi.shared.create(postItem: newPost) { posts in
                DispatchQueue.main.async {
                    self.posts = posts
                    self.tableView.reloadData()
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func clickedSignOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            UserSingleton.shared.user = nil
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "mainToSignIn", sender: self)
    }
}

