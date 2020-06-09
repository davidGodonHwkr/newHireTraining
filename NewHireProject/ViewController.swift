//
//  ViewController.swift
//  NewHireProject
//
//  Created by David Godon on 6/3/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setUpView()
        DbApi.shared.create(authorName: "Jung", authorEmail: "email@email.com", postName: "hello", postDescription: "first post", authorRef: "ref", date: "today")
        DbApi.shared.create(authorName: "Choi", authorEmail: "email2@email.com", postName: "hi", postDescription: "second post", authorRef: "ref2", date: "tomorrow")
        //DispatchQueue.main.async {
            DbApi.shared.read() {
                self.tableView.reloadData()
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
        if DbApi.shared.posts.count > 0 {
            return DbApi.shared.posts.count
        } else {return 0}
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
        let post = DbApi.shared.posts[indexPath.row]
        
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
            DbApi.shared.delete(authorRef: DbApi.shared.posts[indexPath.row].authorRef)
            DbApi.shared.posts.remove(at: indexPath.row)
            print("after removing count: \(DbApi.shared.posts.count)")
            self.tableView.reloadData()
        }
    }

}

