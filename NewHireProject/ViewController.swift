//
//  ViewController.swift
//  NewHireProject
//
//  Created by David Godon on 6/3/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var currentRow: Int! = 0
    @IBOutlet weak var addButton: UIBarButtonItem!
    var posts = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setUpView()
        tableView.register(UINib(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "TableViewCell1")
//        DbApi.shared.create(authorName: "Jung", authorEmail: "email@email.com", postName: "hello", postDescription: "first post", authorRef: "ref", date: "today")
//        DbApi.shared.create(authorName: "Choi", authorEmail: "email2@email.com", postName: "hi", postDescription: "second post", authorRef: "ref2", date: "tomorrow")
        //DispatchQueue.main.async {
            DbApi.shared.read() { posts in
                DispatchQueue.main.async {[weak self] in
                    if let strongSelf = self {
                        strongSelf.posts = posts
                        strongSelf.tableView.reloadData()
                    }
                }
            }
        //}
        
        // DbApi.shared.delete()
        // DbApi.shared.update(authorRef: "ref2", field: "authorName", newValue: "Markus")
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
   //     let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
        let post = posts[indexPath.row]
//

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1", for: indexPath) as! TableViewCell1
        
                cell.authorLabel.text = post.authorName
                cell.dateLabel.text = post.date
                cell.postLabel.text = post.postName
 //       cell.textLabel?.text = "\(post.authorName!) \(post.date!) \(post.postName!)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            DbApi.shared.delete(key: posts[indexPath.row].key) { posts in
                self.posts = posts
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }
         //   posts.remove(at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        self.performSegue(withIdentifier: "InfoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: InfoViewController = segue.destination as! InfoViewController
        secondVC.rowSelected = currentRow
        secondVC.posts = self.posts
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Create Post", message: "Please fill in inputs", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "post name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "post description"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("ok action")
            let textfield1 = alertController.textFields![0]
            let textfield2 = alertController.textFields![1]
            // add it to singleton and database
            let newPost = Posts("jung", "choi", textfield1.text!, textfield2.text!, "author5", "today", "")
           // DbApi.shared.posts.append(newPost)
            DbApi.shared.create(postItem: newPost) { posts in
                self.posts = posts
                self.tableView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

